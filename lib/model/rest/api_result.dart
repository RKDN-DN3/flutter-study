class ApiResult {
  bool? success;
  String? message;
  String? errorCode;
  dynamic data;

  ApiResult({this.success, this.errorCode, this.message, this.data});

  ApiResult.fromJson(Map<String, dynamic> json)
      : success = json["success"],
        message = json["message"],
        errorCode = json["errorCode"],
        data = json["data"];

  @override
  String toString() {
    return "{success : $success, message: $message , errorCode : $errorCode , data : $data}";
  }
}
