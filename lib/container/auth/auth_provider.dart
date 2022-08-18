import 'package:example_flutter/model/data/user.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  String _username = "";
  String _password = "";
  bool isSuccess = false;

  String getUserName() => _username;

  String getPassword() => _password;

  void changeUsername(String text) {
    _username = text;
    notifyListeners();
  }

  void changePassword(String text) {
    _password = text;
    notifyListeners();
  }

  void login() {
    User user = User(username: _username, password: _password);
    isSuccess = true;
    notifyListeners();
  }
}
