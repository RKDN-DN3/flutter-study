import 'package:example_flutter/model/data/chat.dart';
import 'package:example_flutter/model/data/user.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HomeProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  String _currentIdSocket = "";
  Socket socket = io(
      "http://10.20.23.1:3000",
      OptionBuilder().setTransports(['websocket']).setExtraHeaders(
          {'foo': 'bar'}).build());
  List<Chat> listDataChat = [];

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
    socket.onConnectError((connect) {
      print('onConnectError: $connect');
      socket.emit('chatMessage', 'test');
    });
    socket.onConnect((_) {
      print('connect');
      socket.emit('chatMessage', 'test');
    });
    socket.onDisconnect((_) {
      print('disconnect');
    });

    socket.on("getId", (data) {
      _currentIdSocket = data;
    });

    socket.on("sendDataServer", (data) {
      listDataChat.add(Chat.fromJson(data));
      notifyListeners();
    });
  }

  void sendMessage() {
    socket.emit('sendDataClient', 'test');
  }
}
