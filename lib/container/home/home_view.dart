// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:example_flutter/container/home/home_provider.dart';
import 'package:example_flutter/utils/constant.dart';
import 'package:example_flutter/utils/local_storage.dart';
import 'package:example_flutter/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../generated/l10n.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../model/data/chat.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewPage();
}

class _HomeViewPage extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    LocalStorageHelper().getToken().then((value) =>
        value.isEmpty ? Navigator.restorablePushNamed(context, AUTH) : null);
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    homeProvider.connectToServer();
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeNotifier = Provider.of<HomeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    S lang = S.of(context);
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
                  child: renderList(context, homeNotifier.listDataChat,
                      homeNotifier.getCurrentIdSocket()),
                )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    minWidth: width * 0.4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.blue,
                    onPressed: homeNotifier.sendMessage,
                    child: const Text("SEND",
                        style: TextStyle(fontSize: 16.0, color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        )));
  }

  Widget renderItem(Chat data, String currentId) {
    return Align(
        alignment:
            currentId != data.id ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          constraints:
              BoxConstraints(minHeight: 15, minWidth: 200, maxHeight: 400),
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
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) {
          Chat data = listData[index];
          return renderItem(data, currentId);
        });
  }
}
