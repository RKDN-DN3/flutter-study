// ignore_for_file: avoid_print

import 'package:example_flutter/generated/l10n.dart';
import 'package:example_flutter/model/data/user.dart';
import 'package:example_flutter/model/rest/api_result.dart';
import 'package:example_flutter/model/state/state_custom.dart';
import 'package:example_flutter/repository/auth_repository.dart';
import 'package:example_flutter/utils/local_storage.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String _username = "";
  String _password = "";
  bool isSuccess = false;
  String error = "";
  StateCustom? _state;

  String getUserName() => _username;
  StateCustom? getState() => _state;
  String getPassword() => _password;

  void changeUsername(String text) {
    _username = text;
    notifyListeners();
  }

  void removeStateError() {
    _state = StateCustom.error("");
    notifyListeners();
  }

  void changePassword(String text) {
    _password = text;
    notifyListeners();
  }

  Future<void> login() async {
    User user = User(username: _username, password: _password);
    await AuthRepository().login(user).then((ApiResult response) {
      if (response != null && response.success == true) {
        String token = response.data!["token"] as String;
        if (token.isNotEmpty == true) {
          LocalStorageHelper().saveToken(token);
          _state = StateCustom.success(true);
          return notifyListeners();
        }
      }
      _state = StateCustom.error(response.message ?? S.current.login_error);
    }).onError((Exception error, stackTrace) {
      _state = StateCustom.error(error.toString());
    });
    notifyListeners();
  }
}
