import 'package:goosit/models/error_model.dart';
import 'package:goosit/pages/register/register_controller.dart';
import 'package:goosit/pages/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mock_navigator_observer.dart';
import '../../mocks/mock_page.dart';

void main() {
  late RegisterControllerMock controller;
  late TestHelper testHelper;

  setUp(() {
    testHelper = TestHelper();
    controller = RegisterControllerMock();
  });

  group('User tries to register >', () {
    group('given user clicks on register button,', () {
      testWidgets('when email is empty, then do not register',
          (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        await testHelper.register(
          tester: tester,
          email: "",
        );

        expect(controller.hasTriedToRegister, false);
      });
      testWidgets('when email is invalid, then do not register',
          (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        await testHelper.register(
          tester: tester,
          email: "invalidEmail",
        );

        expect(controller.hasTriedToRegister, false);
      });
      testWidgets('when password is empty, then do not register',
          (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        await testHelper.register(
          tester: tester,
          password: "",
        );

        expect(controller.hasTriedToRegister, false);
      });
      testWidgets('when confirm password is empty, then do not register',
          (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        await testHelper.register(
          tester: tester,
          confirmPassword: "",
        );

        expect(controller.hasTriedToRegister, false);
      });
      testWidgets(
          'when password and confirm password are different, then do not register',
          (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        await testHelper.register(
          tester: tester,
          password: "password",
          confirmPassword: "confirm",
        );

        expect(controller.hasTriedToRegister, false);
      });
      testWidgets('when form is valid, then register',
          (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        await testHelper.register(tester: tester);

        expect(controller.hasTriedToRegister, true);
      });
    });
    group('given user is registering,', () {
      setUp(() {
        controller.state.value.isRegistering = true;
      });
      testWidgets('then show register loader', (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        expect(find.byKey(const Key("register-loader")), findsOneWidget);
      });
      group('when registered,', () {
        testWidgets('then take user to home page', (WidgetTester tester) async {
          controller.state.value.isRegistered = true;

          await testHelper.createPage(tester, controller);
          await tester.pumpAndSettle();

          expect(testHelper.mockObserver.replacedBy, '/home');
        });
      });
      testWidgets('when error, then show error', (WidgetTester tester) async {
        controller.state.value.error = ErrorModel(
          code: "anyCode",
          message: "anyMessage",
        );

        await testHelper.createPage(tester, controller);

        expect(controller.hasShowedErrorMessage, true);
      });
    });
  });
}

class RegisterControllerMock extends RegisterController {
  bool hasTriedToRegister = false;
  bool hasShowedErrorMessage = false;

  RegisterControllerMock() : super();

  @override
  register() {
    hasTriedToRegister = true;
  }

  @override
  showErrorMessage(BuildContext context) {
    hasShowedErrorMessage = true;
  }
}

class TestHelper {
  late MockNavigatorObserver mockObserver;

  createPage(WidgetTester tester, RegisterController? controller) async {
    mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => RegisterPage(controller: controller),
          '/home': (context) => const MockPage()
        },
        navigatorObservers: [mockObserver],
      ),
    );
  }

  clickRegisterButton(WidgetTester tester) async {
    await tester.tap(find.byKey(const Key("register-button")));
    await tester.pumpAndSettle();
  }

  findEmailRequiredError() {
    return find.byKey(const Key("email-required-error"));
  }

  setEmail(WidgetTester tester, String value) async {
    await tester.enterText(find.bySemanticsLabel("Email"), value);
    await tester.pumpAndSettle();
  }

  setPassword(WidgetTester tester, String value) async {
    await tester.enterText(find.byKey(const Key("password")), value);
    await tester.pumpAndSettle();
  }

  setConfirmPassword(WidgetTester tester, String value) async {
    await tester.enterText(find.byKey(const Key("confirm-password")), value);
    await tester.pumpAndSettle();
  }

  register({
    required WidgetTester tester,
    String email = "any@email.com",
    String password = "anyPassword",
    String confirmPassword = "anyPassword",
  }) async {
    await setEmail(tester, email);
    await setPassword(tester, password);
    await setConfirmPassword(tester, confirmPassword);
    await clickRegisterButton(tester);
  }
}
