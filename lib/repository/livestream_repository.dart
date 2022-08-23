import 'package:example_flutter/dio_helper/dio_helper.dart';
import 'package:example_flutter/model/data/token.dart';
import 'package:example_flutter/model/rest/api_result.dart';

class LiveStreamRepository {
  Future<ApiResult> generateToken(Token data) async {
    ApiResult result = ApiResult();
    var response = await DioHelper().post("livestream/generaterToken", data);
    result = ApiResult.fromJson(response!);
    return result;
  }
}
