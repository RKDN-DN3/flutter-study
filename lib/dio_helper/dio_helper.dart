import 'package:dio/dio.dart';
import 'package:example_flutter/utils/local_storage.dart';

class DioHelper {
  Dio dio = Dio(BaseOptions(
    baseUrl: "http://10.20.22.173:8088/",
    connectTimeout: 6000,
    receiveTimeout: 6000,
    headers: {"content-Type": "application/json"},
  ));

  Future<Map<String, dynamic>?> get(String url) async {
    try {
      await LocalStorageHelper().getToken().then((value) {
        dio.options.headers["Authorization"] = "Bearer $value";
      });
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      // throw Exception(e.message);
    }
    return null;
  }

  Future<Map<String, dynamic>?> post(String url, dynamic data) async {
    try {
      await LocalStorageHelper().getToken().then((value) {
        dio.options.headers["Authorization"] = "Bearer $value";
      });
      var response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      // throw Exception(e.message);
    }
    return null;
  }

  Future<Map<String, dynamic>?> postFile(String url, dynamic data) async {
    try {
      await LocalStorageHelper().getToken().then((value) {
        dio.options.headers["Authorization"] = "Bearer $value";
      });
      var response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      // throw Exception(e.message);
    }
    return null;
  }
}
