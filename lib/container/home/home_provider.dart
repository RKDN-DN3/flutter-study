// ignore_for_file: unused_field

import 'package:example_flutter/generated/l10n.dart';
import 'package:example_flutter/model/data/chat.dart';
import 'package:example_flutter/model/state/state_custom.dart';
import 'package:example_flutter/repository/employee_repository.dart';
import 'package:example_flutter/utils/socket_config.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HomeProvider extends ChangeNotifier {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _count = 0;
  String _currentIdSocket = "";
  List<Chat> listDataChat = [];
  String _message = "";
  StateCustom? _state;
  Socket socket = io(
      SocketConfig.URL_SOCKET,
      OptionBuilder().setTransports(['websocket']).setExtraHeaders(
          {'foo': 'bar'}).build());

  int get count => _count;

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

  void decrement() {
    _count--;
    notifyListeners();
  }

  String getCurrentIdSocket() => _currentIdSocket;

  Future<void> getListEmployee() async {
    await EmployeeRepository().getListEmployee().then((value) {});
  }

  ScrollController getScrollController() => _scrollController;

  StateCustom? getState() => _state;

  TextEditingController getTextEditController() => _controller;

  void increment() {
    _count++;
    notifyListeners();
  }

  void sendMessage() {
    if (_message.isNotEmpty) {
      Chat data = Chat(content: _message, id: _currentIdSocket);
      socket.emit(SocketConfig.SEND_MESSAGE_EVENT, data);
      _message = "";
      _controller.clear();
    } else {
      _state = StateCustom.error(S().empty_message);
    }
    notifyListeners();
  }

  void setMessage(String text) => _message = text;

  void clearError() {
    _state = StateCustom.error("");
    notifyListeners();
  }
}
