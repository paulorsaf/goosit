import 'package:goosit/pages/register/register_form.dart';
import 'package:goosit/pages/register/register_state.dart';
import 'package:goosit/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterController {
  late AuthServiceInterface _authService;
  late RegisterForm form;

  final state = ValueNotifier<RegisterState>(RegisterState.initialState());

  RegisterController({
    AuthServiceInterface? authService,
  }) {
    form = RegisterForm();
    _authService = authService ?? AuthService();
  }

  register() async {
    state.value = RegisterState.registering();
    return await _authService
        .register(email: form.email, password: form.password)
        .then((user) {
      state.value = RegisterState.registered();
    }).catchError((error) {
      state.value = RegisterState.err(error);
    });
  }

  goToHomePage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1), () {
      Navigator.of(context).pushReplacementNamed('/home');
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
}
