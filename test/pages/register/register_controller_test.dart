import 'package:goosit/models/error_model.dart';
import 'package:goosit/models/user_model.dart';
import 'package:goosit/pages/register/register_controller.dart';
import 'package:goosit/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class AuthServiceMock extends Mock implements AuthServiceInterface {
  late ErrorModel? error;
  late Future<UserModel> registerResponse;
  AuthServiceMock() {
    error = null;
  }
  @override
  Future<UserModel> register({
    required String email,
    required String password,
  }) {
    if (error != null) {
      return Future<UserModel>.error(error!);
    }
    return registerResponse;
  }
}

void main() {
  AuthServiceMock authService = AuthServiceMock();
  RegisterController controller = RegisterController(authService: authService);
  group('Register > ', () {
    group('given registering, ', () {
      test('then start registration', () async {
        authService.registerResponse =
            Future<UserModel>.delayed(const Duration(seconds: 10000), () {
          return UserModel(email: "any@email.com", id: "anyId");
        });

        controller.register();

        expect(controller.state.value.isRegistering, true);
      });
    });
    group('when success, ', () {
      setUp(() {
        authService.registerResponse = Future<UserModel>.value(
            UserModel(email: "any@email.com", id: "anyId"));
      });
      test('then register user', () async {
        await controller.register();

        expect(controller.state.value.isRegistered, true);
      });
    });
    group('when fail, ', () {
      ErrorModel error = ErrorModel(code: "anyCode", message: "anyMessage");
      setUp(() {
        authService.error = error;
      });
      test('then do not register user', () async {
        try {
          await controller.register();
        } catch (e) {
          expect(controller.state.value.isRegistered, false);
        }
      });
      test('then set error', () async {
        try {
          await controller.register();
        } catch (e) {
          expect(controller.state.value.error, error);
        }
      });
    });
  });
}
