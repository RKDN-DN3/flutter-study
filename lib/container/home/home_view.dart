// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(image_auth), fit: BoxFit.cover)),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: height * 0.05),
            Text(
              lang.home,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: width * 0.05),
            ),
            MaterialButton(
              minWidth: width * 0.4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.blue,
              onPressed: homeNotifier.sendMessage,
              child: Text(lang.login,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white)),
            ),
            ListView.builder(
                itemCount: homeNotifier.listDataChat.toList().length,
                itemBuilder: (BuildContext context, int index) {
                  Chat chatData = homeNotifier.listDataChat.elementAt(index);
                  return Container(
                    height: 50,
                    child: Center(child: Text(chatData.content ?? "")),
                  );
                }),
          ],
        ),
      ),
    ));
  }
}
