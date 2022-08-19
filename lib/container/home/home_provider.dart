import 'dart:developer';

import 'package:example_flutter/model/data/chat.dart';
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
      "http://10.20.22.173:3000",
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
    socket.on("sendDataServer", (data) {
      listDataChat.add(Chat.fromJson(data));
      notifyListeners();
    });
    socket.on("new_message_chat", (data) {
      Chat chatData = Chat.fromJson(Map<String, dynamic>.from(data));
      listDataChat.add(chatData);
      notifyListeners();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  void sendMessage() {
    Chat data = Chat(content: _message, id: _currentIdSocket);
    socket.emit('sendChatMessage', data);
    _message = "";
    _controller.clear();
    notifyListeners();
  }
}
