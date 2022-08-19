// ignore_for_file: avoid_print

import 'package:example_flutter/container/home/home_provider.dart';
import 'package:example_flutter/utils/constant.dart';
import 'package:example_flutter/utils/local_storage.dart';
import 'package:example_flutter/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../model/data/chat.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewPage();
}

class _HomeViewPage extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late Animation _arrowAnimation;
  late AnimationController _arrowAnimationController;
  late HomeProvider homeProvider;

  @override
  void initState() {
    super.initState();
    LocalStorageHelper().getToken().then((value) =>
        value.isEmpty ? Navigator.restorablePushNamed(context, AUTH) : null);
    Provider.of<HomeProvider>(context, listen: false).connectToServer();

    _arrowAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _arrowAnimation =
        Tween(begin: 0.0, end: 10.0).animate(_arrowAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    S lang = S.of(context);
    homeProvider = Provider.of<HomeProvider>(context);
    return SafeArea(
        top: true,
        bottom: true,
        left: false,
        right: false,
        child: Scaffold(
            body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image_auth), fit: BoxFit.cover)),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                Text(
                  lang.home,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: width * 0.05),
                ),
                SizedBox(height: height * 0.02),
                Expanded(
                    child: Align(
                  alignment: Alignment.center,
                  child: renderList(context, homeProvider.listDataChat,
                      homeProvider.getCurrentIdSocket()),
                )),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: renderInputAndSend(context))
              ],
            ),
          ),
        )));
  }

  Widget renderInputAndSend(BuildContext context) {
    S lang = S.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var _controller = TextEditingController();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
            width: 200,
            height: height * 0.1,
            child: TextFormField(
                controller: homeProvider.getTextEditController(),
                onChanged: (text) => homeProvider.setMessage(text),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: lang.password,
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: height * 0.1,
                      maxWidth: width * 0.1,
                    )))),
        MaterialButton(
          minWidth: width * 0.4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.blue,
          onPressed: homeProvider.sendMessage,
          child: const Text("SEND",
              style: TextStyle(fontSize: 16.0, color: Colors.white)),
        ),
      ],
    );
  }

  Widget firstChild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        AnimatedBuilder(
          animation: _arrowAnimationController,
          builder: (context, child) => Transform.rotate(
            angle: _arrowAnimation.value,
            child: const Icon(
              Icons.expand_more,
              size: 50.0,
              color: Colors.black,
            ),
          ),
        ),
        MaterialButton(
          color: Colors.white,
          textColor: Colors.black,
          padding: const EdgeInsets.all(12.0),
          onPressed: () {
            // _arrowAnimationController.isCompleted
            //     ? _arrowAnimationController.reverse()
            //     : _arrowAnimationController.forward();
            _arrowAnimationController.repeat();
          },
          onLongPress: () {
            _arrowAnimationController.stop();
          },
          splashColor: Colors.red,
          child: const Text('Start Icon Animation'),
        )
      ],
    );
  }

  Widget renderItem(Chat data, String currentId) {
    return Align(
        alignment:
            currentId != data.id ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          constraints: const BoxConstraints(
              minHeight: 15, minWidth: 200, maxHeight: 400),
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: currentId != data.id ? Colors.blue : Colors.white,
              border: Border.all(
                color: currentId != data.id ? Colors.blue : Colors.white,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(3))),
          child: Text(
            data.content!,
            textAlign: TextAlign.center,
          ),
        ));
  }

  Widget renderList(
      BuildContext context, List<Chat> listData, String currentId) {
    return ListView.builder(
        controller: homeProvider.getScrollController(),
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) {
          Chat data = listData[index];
          return renderItem(data, currentId);
        });
  }
}
