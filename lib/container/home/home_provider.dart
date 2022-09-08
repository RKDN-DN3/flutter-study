// ignore_for_file: unused_field

import 'package:dio/dio.dart';
import 'package:example_flutter/generated/l10n.dart';
import 'package:example_flutter/model/data/chat.dart';
import 'package:example_flutter/model/data/token.dart';
import 'package:example_flutter/model/state/state_custom.dart';
import 'package:example_flutter/repository/employee_repository.dart';
import 'package:example_flutter/repository/livestream_repository.dart';
import 'package:example_flutter/repository/upload_repository.dart';
import 'package:example_flutter/utils/socket_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HomeProvider extends ChangeNotifier {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _count = 0;
  String _currentIdSocket = "";
  String _token = "";
  String currentMenu = "Home";
  List<Chat> listDataChat = [];
  String _message = "";
  StateCustom? _state;
  Socket socket = io(
      SocketConfig.URL_SOCKET,
      OptionBuilder().setTransports(['websocket']).setExtraHeaders(
          {'foo': 'bar'}).build());

  int get count => _count;

  void changeCurrentMenu(String value) {
    currentMenu = value;
    notifyListeners();
  }

  void clearError() {
    _state = StateCustom.error("");
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
      Chat chatData = Chat.fromJson(Map<String, dynamic>.from(data));
      listDataChat.add(chatData);
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
      notifyListeners();
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

  Future<void> getToken() async {
    Token token =
        Token(room_id: "TuPM", user_id: "tupt", role: "new-role-7124");
    LiveStreamRepository().generateToken(token).then((value) {
      _token = value.data;
    });
  }

  void increment() {
    _count++;
    notifyListeners();
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image!.path,
            filename: image.path.split('/').last),
      });
      UploadRepository().uploadImage(formData).then((value) {
        print("value $value");
      });
    } catch (e) {
      print("error $e");
    }
  }

  void sendMessage() {
    try {
      if (_message.isNotEmpty) {
        Chat data = Chat(content: _message, id: _currentIdSocket);
        socket.emit(SocketConfig.SEND_MESSAGE_EVENT, data);
        _message = "";
        _controller.clear();
      } else {
        _state = StateCustom.error(S().empty_message);
      }
      notifyListeners();
    } catch (e) {
      print("error $e");
    }
  }

  void setMessage(String text) => _message = text;
}
