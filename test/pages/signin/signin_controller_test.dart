import 'package:goosit/models/user_model.dart';
import 'package:goosit/pages/signin/signin_controller.dart';
import 'package:goosit/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class AuthServiceMock extends Mock implements AuthServiceInterface {
  late Future<UserModel> loginResponse;
  late Future<void> recoverPasswordResponse;
  @override
  Future<UserModel> login({required String email, required String password}) {
    return loginResponse;
  }

  @override
  Future<void> recoverPassword({required String email}) {
    return recoverPasswordResponse;
  }
}

void main() {
  AuthServiceMock authService = AuthServiceMock();
  SignInController controller = SignInController(authService: authService);
  group('Sign in > ', () {
    group('given signing in, ', () {
      setUp(() {
        authService.loginResponse =
            Future<UserModel>.delayed(const Duration(seconds: 10000), () {
          return UserModel(email: "any@email.com", id: "anyId");
        });
      });
      test('then start sign in', () async {
        controller.signIn();

        expect(controller.state.value.isSigningIn, true);
      });
    });
    group('when success, ', () {
      setUp(() {
        authService.loginResponse = Future<UserModel>.value(
            UserModel(email: "any@email.com", id: "anyId"));
      });
      test('then sign in', () async {
        await controller.signIn();

        expect(controller.state.value.isSignedIn, true);
      });
    });
  });
  group('Recover password >', () {
    group('given recovering password,', () {
      setUp(() {
        authService.recoverPasswordResponse =
            Future<void>.delayed(const Duration(seconds: 10000));
      });
      test('then start to recover password', () async {
        controller.recoverPassword();

        expect(controller.state.value.isRecoveringPassword, true);
      });
    });
    group('given password recovered,', () {
      setUp(() {
        authService.recoverPasswordResponse = Future<void>.value(null);
      });
      test('then set recovering password as recovered', () async {
        await controller.recoverPassword();

        expect(controller.state.value.isRecoveredPassword, true);
      });
    });
  });
}
