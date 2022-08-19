import 'dart:developer';

import 'package:example_flutter/model/data/chat.dart';
import 'package:example_flutter/repository/employee_repository.dart';
import 'package:example_flutter/utils/constant.dart';
import 'package:example_flutter/utils/socket_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HomeProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  String _currentIdSocket = "";
  final TextEditingController _controller = TextEditingController();
  List<Chat> listDataChat = [];
  String _message = "";
  final ScrollController _scrollController = ScrollController();

  Socket socket = io(
      SocketConfig.URL_SOCKET,
      OptionBuilder().setTransports(['websocket']).setExtraHeaders(
          {'foo': 'bar'}).build());

  ScrollController getScrollController() => _scrollController;
  TextEditingController getTextEditController() => _controller;
  String getCurrentIdSocket() => _currentIdSocket;

  void setMessage(String text) => _message = text;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  Future<void> connectToServer() async {
    socket.connect();
    socket.onConnectError((connect) {});
    socket.onConnect((_) {
      _currentIdSocket = socket.id!;
    });
    socket.onDisconnect((_) {
      _currentIdSocket = "";
    });

    socket.on(SocketConfig.NEW_MESSAGE_EVENT, (data) {
      print("data $data");
      Chat chatData = Chat.fromJson(Map<String, dynamic>.from(data));
      listDataChat.add(chatData);
      notifyListeners();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  void sendMessage() {
    Chat data = Chat(content: _message, id: _currentIdSocket);
    socket.emit(SocketConfig.SEND_MESSAGE_EVENT, data);
    _message = "";
    _controller.clear();
    notifyListeners();
  }

  Future<void> getListEmployee() async {
    await EmployeeRepository()
        .getListEmployee()
        .then((value) => {print("getListEmployee $value")});
  }
}
