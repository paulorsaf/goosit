import 'package:goosit/models/error_model.dart';
import 'package:goosit/pages/signin/signin_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('given initial state, then validate state', () async {
    SignInState state = SignInState.initialState();

    expect(state.error, null);
    expect(state.isRecoveredPassword, false);
    expect(state.isRecoveringPassword, false);
    expect(state.isSignedIn, false);
    expect(state.isSigningIn, false);
  });
  test('given recovering password, then validate state', () async {
    SignInState state = SignInState.recoveringPassword();

    expect(state.error, null);
    expect(state.isRecoveredPassword, false);
    expect(state.isRecoveringPassword, true);
    expect(state.isSignedIn, false);
    expect(state.isSigningIn, false);
  });
  test('given password recovered, then validate state', () async {
    SignInState state = SignInState.passwordRecovered();

    expect(state.error, null);
    expect(state.isRecoveredPassword, true);
    expect(state.isRecoveringPassword, false);
    expect(state.isSignedIn, false);
    expect(state.isSigningIn, false);
  });
  test('given signing in, then validate state', () async {
    SignInState state = SignInState.signingIn();

    expect(state.error, null);
    expect(state.isRecoveredPassword, false);
    expect(state.isRecoveringPassword, false);
    expect(state.isSignedIn, false);
    expect(state.isSigningIn, true);
  });
  test('given signed in, then validate state', () async {
    SignInState state = SignInState.signedIn();

    expect(state.error, null);
    expect(state.isRecoveredPassword, false);
    expect(state.isRecoveringPassword, false);
    expect(state.isSignedIn, true);
    expect(state.isSigningIn, false);
  });
  test('given error, then validate state', () async {
    final error = ErrorModel(code: "anyCode", message: "anyMessage");
    SignInState state = SignInState.err(error);

    expect(state.error, error);
    expect(state.isRecoveredPassword, false);
    expect(state.isRecoveringPassword, false);
    expect(state.isSignedIn, false);
    expect(state.isSigningIn, false);
  });
}
