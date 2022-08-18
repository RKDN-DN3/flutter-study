import 'dart:convert';

import 'package:example_flutter/dio_helper/dio_helper.dart';
import 'package:example_flutter/model/rest/api_result.dart';

import '../model/data/user.dart';

class AuthRepository {
  Future<ApiResult> login(User user) async {
    ApiResult result = ApiResult();
    var response = await DioHelper().post("auth/login", user);
    result = ApiResult.fromJson(response!);
    return result;
  }
}
