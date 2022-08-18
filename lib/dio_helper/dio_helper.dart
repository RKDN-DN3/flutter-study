import 'package:dio/dio.dart';

class DioHelper {
  Dio dio = Dio(BaseOptions(
    baseUrl: "http://localhost:8080/",
    connectTimeout: 6000,
    receiveTimeout: 6000,
    headers: {"content-Type": "application/json"},
  ));

  Future<Map<String, dynamic>?> get(String url) async {
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    return null;
  }

  Future<Map<String, dynamic>?> post(String url, var data) async {
    try {
      var response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    return null;
  }
}
