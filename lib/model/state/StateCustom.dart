// ignore: file_names
class StateCustom {
  StateCustom._();
  factory StateCustom.success(bool foo) = SuccessStateCustom;
  factory StateCustom.error(String foo) = ErrorStateCustom;
}

class ErrorStateCustom extends StateCustom {
  ErrorStateCustom(this.msg) : super._();
  String msg = "";
}

class SuccessStateCustom extends StateCustom {
  SuccessStateCustom(this.isSuccess) : super._();
  bool isSuccess = false;
}
