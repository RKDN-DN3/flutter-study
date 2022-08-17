class ApiResult {
  bool success;
  String? message;
  String? errorCode;
  Object? data;

  ApiResult(this.success, this.errorCode, this.message, this.data);
}
