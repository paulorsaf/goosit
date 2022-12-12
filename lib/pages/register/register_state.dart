import 'package:goosit/models/error_model.dart';

class RegisterState {
  ErrorModel? error;
  bool isRegistered;
  bool isRegistering;

  RegisterState({
    required this.isRegistered,
    required this.isRegistering,
    this.error,
  });

  static initialState() {
    return RegisterState(
      isRegistered: false,
      isRegistering: false,
    );
  }

  static registering() {
    return RegisterState(
      isRegistered: false,
      isRegistering: true,
    );
  }

  static registered() {
    return RegisterState(
      isRegistered: true,
      isRegistering: false,
    );
  }

  static err(ErrorModel error) {
    return RegisterState(
      error: error,
      isRegistered: false,
      isRegistering: false,
    );
  }
}
