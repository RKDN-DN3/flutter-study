import 'package:dio/dio.dart';
import 'package:example_flutter/dio_helper/dio_helper.dart';
import 'package:example_flutter/model/rest/api_result.dart';

class UploadRepository {
  Future<ApiResult> uploadImage(FormData data) async {
    ApiResult result = ApiResult();
    var response = await DioHelper().post("upload/image", data);
    result = ApiResult.fromJson(response!);
    return result;
  }
}
