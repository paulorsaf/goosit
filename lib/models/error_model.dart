class ErrorModel extends Error {
  String code;
  String message;

  ErrorModel({required this.code, required this.message});
}
