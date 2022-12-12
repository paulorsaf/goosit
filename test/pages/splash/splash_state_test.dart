import 'package:goosit/models/error_model.dart';
import 'package:goosit/pages/splash/splash_page.dart';
import 'package:goosit/pages/splash/splash_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('given initial state, then validate state', () async {
    SplashState state = SplashState.initialState();

    expect(state.isLogged, null);
  });
  test('given user logged, then validate state', () async {
    SplashState state = SplashState.userLogged();

    expect(state.isLogged, true);
  });
  test('given user not logged, then validate state', () async {
    SplashState state = SplashState.userNotLogged();

    expect(state.isLogged, false);
  });
}
