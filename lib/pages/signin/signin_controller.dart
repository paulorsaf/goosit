import 'package:goosit/models/error_model.dart';
import 'package:goosit/pages/signin/signin_form.dart';
import 'package:goosit/pages/signin/signin_state.dart';
import 'package:goosit/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignInController {
  late AuthServiceInterface _authService;
  late SignInForm form;

  final state = ValueNotifier<SignInState>(SignInState.initialState());

  SignInController({
    AuthServiceInterface? authService,
  }) {
    form = SignInForm();
    _authService = authService ?? AuthService();
  }

  toggleRevealPassword() {
    state.value = SignInState(
      isSigningIn: false,
      isSignedIn: false,
      isRecoveredPassword: false,
      isRecoveringPassword: false,
    );
  }

  signIn() async {
    _setSigningIn();
    return await _authService
        .login(email: form.email, password: form.password)
        .then((user) {
      _setSignedIn();
    }).catchError((error) {
      _setError(error);
    });
  }

  recoverPassword() async {
    _setRecoveringPassword();
    await _authService.recoverPassword(email: form.email).then((_) {
      _setPasswordRecovered();
    }).catchError((error) {
      _setError(error);
    });
  }

  goToHomePage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  showRecoverPasswordMessage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Email enviado com sucesso."),
        action: SnackBarAction(
          label: "FECHAR",
          onPressed: () {},
        ),
      ));
    });
  }

  showErrorMessage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(state.value.error!.message),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          textColor: Colors.white,
          label: "FECHAR",
          onPressed: () {},
        ),
      ));
    });
  }

  _setSigningIn() {
    state.value = SignInState.signingIn();
  }

  _setSignedIn() {
    state.value = SignInState.signedIn();
  }

  _setError(ErrorModel error) {
    state.value = SignInState.err(error);
  }

  _setRecoveringPassword() {
    state.value = SignInState.recoveringPassword();
  }

  _setPasswordRecovered() {
    state.value = SignInState.passwordRecovered();
  }
}
