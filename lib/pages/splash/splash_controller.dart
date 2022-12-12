import 'package:goosit/pages/splash/splash_state.dart';
import 'package:goosit/services/auth_service.dart';
import 'package:flutter/material.dart';

class SplashController {
  late AuthServiceInterface _authService;

  final state = ValueNotifier<SplashState>(SplashState.initialState());

  SplashController({
    AuthServiceInterface? authService,
  }) {
    _authService = authService ?? AuthService();
  }

  getCurrentUser() {
    _authService.getCurrentUser().then((user) {
      state.value = SplashState.userLogged();
    }).catchError((error) {
      state.value = SplashState.userNotLogged();
    });
  }

  goToSignInPage(BuildContext context) {
    Future<void>.delayed(const Duration(milliseconds: 1)).then((_) {
      Navigator.of(context).pushNamed('/signin');
    });
  }

  goToHomePage(BuildContext context) {
    Future<void>.delayed(const Duration(milliseconds: 1)).then((_) {
      Navigator.of(context).pushNamed('/home');
    });
  }
}
