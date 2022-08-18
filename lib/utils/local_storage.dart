import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("TOKEN", token);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("TOKEN") ?? "";
  }
}
