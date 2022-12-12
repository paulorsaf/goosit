import 'package:goosit/models/error_model.dart';
import 'package:goosit/models/user_model.dart';
import 'package:goosit/pages/splash/splash_controller.dart';
import 'package:goosit/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class AuthServiceMock extends Mock implements AuthServiceInterface {
  late Future<UserModel> getCurrentUserResponse;
  @override
  Future<UserModel> getCurrentUser() {
    return getCurrentUserResponse;
  }
}

void main() {
  late AuthServiceMock authService;
  late SplashController controller;

  setUp(() {
    authService = AuthServiceMock();
    controller = SplashController(authService: authService);
  });

  test('given user is logged, then set user as logged', () async {
    authService.getCurrentUserResponse =
        Future.value(UserModel(id: "anyId", email: "any@email.com"));

    await controller.getCurrentUser();

    expect(controller.state.value.isLogged, true);
  });
  test('given user is not logged, then return error', () async {
    authService.getCurrentUserResponse = Future<UserModel>.error(
      ErrorModel(code: "anyCode", message: "anyMessage"),
    );

    try {
      await controller.getCurrentUser();
      fail("exception not thrown");
    } catch (e) {
      expect(controller.state.value.isLogged, false);
    }
  });
}
