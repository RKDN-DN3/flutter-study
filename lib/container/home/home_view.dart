// ignore_for_file: avoid_print

import 'package:example_flutter/container/home/home_provider.dart';
import 'package:example_flutter/model/state/state_custom.dart';
import 'package:example_flutter/utils/constant.dart';
import 'package:example_flutter/utils/local_storage.dart';
import 'package:example_flutter/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../model/data/chat.dart';

Future<void> _showMyDialog(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.of(context).notification),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(S.of(context).approve),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewPage();
}

class _HomeViewPage extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late HomeProvider homeProvider;

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

  @override
  void initState() {
    super.initState();
    LocalStorageHelper().getToken().then((value) {
      value.isEmpty ? {Navigator.restorablePushNamed(context, AUTH)} : null;
    });
    var provider = Provider.of<HomeProvider>(context, listen: false);
    provider.connectToServer();
    provider.getListEmployee();
    provider.addListener(() {
      StateCustom? state = provider.getState();
      if (state != null && state is ErrorStateCustom && state.msg.isNotEmpty) {
        _showMyDialog(context, state.msg);
        provider.clearError();
      }
    });
  }

  Widget renderInputAndSend(BuildContext context) {
    S lang = S.of(context);
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(width: width * 0.02),
        Expanded(
            child: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          controller: homeProvider.getTextEditController(),
          onChanged: (text) => homeProvider.setMessage(text),
        )),
        SizedBox(width: width * 0.02),
        MaterialButton(
          minWidth: width * 0.2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.blue,
          onPressed: homeProvider.sendMessage,
          child: Text(lang.send,
              style: const TextStyle(fontSize: 16.0, color: Colors.white)),
        ),
      ],
    );
  }

  Widget renderItem(Chat data, String currentId, BuildContext context) {
    S lang = S.of(context);
    String? content =
        data.content?.isNotEmpty == true ? data.content : lang.empty_message;
    return Align(
        alignment:
            currentId != data.id ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          constraints:
              const BoxConstraints(minHeight: 15, minWidth: 20, maxHeight: 400),
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: currentId != data.id ? Colors.blue : Colors.white,
              border: Border.all(
                color: currentId != data.id ? Colors.blue : Colors.white,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(3))),
          child: Text(
            content!,
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
          return renderItem(data, currentId, context);
        });
  }
}
