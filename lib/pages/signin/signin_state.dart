import 'package:goosit/models/error_model.dart';

class SignInState {
  ErrorModel? error;
  bool isRecoveredPassword = true;
  bool isRecoveringPassword = false;
  bool isSignedIn = false;
  bool isSigningIn = false;

  SignInState({
    required this.isSigningIn,
    required this.isSignedIn,
    required this.isRecoveredPassword,
    required this.isRecoveringPassword,
    this.error,
  });

  static initialState() {
    return SignInState(
      isSigningIn: false,
      isSignedIn: false,
      isRecoveredPassword: false,
      isRecoveringPassword: false,
    );
  }

  static err(ErrorModel error) {
    return SignInState(
      error: error,
      isSigningIn: false,
      isSignedIn: false,
      isRecoveredPassword: false,
      isRecoveringPassword: false,
    );
  }

  static passwordRecovered() {
    return SignInState(
      isSigningIn: false,
      isSignedIn: false,
      isRecoveredPassword: true,
      isRecoveringPassword: false,
    );
  }

  static recoveringPassword() {
    return SignInState(
      isSigningIn: false,
      isSignedIn: false,
      isRecoveredPassword: false,
      isRecoveringPassword: true,
    );
  }

  static signedIn() {
    return SignInState(
      isSigningIn: false,
      isSignedIn: true,
      isRecoveredPassword: false,
      isRecoveringPassword: false,
    );
  }

  static signingIn() {
    return SignInState(
      isSigningIn: true,
      isSignedIn: false,
      isRecoveredPassword: false,
      isRecoveringPassword: false,
    );
  }
}
