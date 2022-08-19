import 'package:example_flutter/dio_helper/dio_helper.dart';
import 'package:example_flutter/model/rest/api_result.dart';

class EmployeeRepository {
  Future<ApiResult> getListEmployee() async {
    ApiResult result = ApiResult();
    var response = await DioHelper().get("employee/list");
    result = ApiResult.fromJson(response!);
    return result;
  }
}
