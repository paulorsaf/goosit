import 'package:goosit/models/error_model.dart';
import 'package:goosit/pages/home/home_page.dart';
import 'package:goosit/pages/register/register_page.dart';
import 'package:goosit/pages/signin/signin_controller.dart';
import 'package:goosit/pages/signin/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  late SignInControllerMock controller;
  late TestHelper testHelper;

  setUp(() {
    testHelper = TestHelper();
    controller = SignInControllerMock();
  });
  group('User tries to recover password >', () {
    group('given user clicks on recover password button,', () {
      testWidgets('when email is invalid, then do not recover password',
          (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        await testHelper.clickRecoverPasswordButton(tester);

        expect(controller.hasTriedToRecoverPassword, false);
      });
      testWidgets('when email is valid, then recover password',
          (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        await testHelper.recoverPassword(tester);

        expect(controller.hasTriedToRecoverPassword, true);
      });
    });
    group('given recovering password button,', () {
      setUp(() {
        controller.state.value.isRecoveringPassword = true;
      });
      testWidgets('then show recover password loading',
          (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        expect(
            find.byKey(const Key("recover-password-loader")), findsOneWidget);
      });
      group('when password recovered,', () {
        setUp(() {
          controller.state.value.isRecoveredPassword = true;
          controller.state.value.isRecoveringPassword = false;
        });
        testWidgets('then hide recover password loading',
            (WidgetTester tester) async {
          await testHelper.createPage(tester, null);

          expect(
              find.byKey(const Key("recover-password-loader")), findsNothing);
        });
        testWidgets('then show recover password success message',
            (WidgetTester tester) async {
          await testHelper.createPage(tester, controller);

          expect(controller.hasShowedRecoverPasswordMessage, true);
        });
      });
    });
  });

  group('User tries to login >', () {
    group('given user clicks on sign in button,', () {
      testWidgets('when email is empty, then do not sign in',
          (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        await testHelper.signIn(tester: tester, email: "");

        expect(controller.hasTriedToSignIn, false);
      });
      testWidgets('when email is invalid, then do not sign in',
          (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        await testHelper.signIn(tester: tester, email: "invalid");

        expect(controller.hasTriedToSignIn, false);
      });
      testWidgets('when password is empty, then do not sign in',
          (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        await testHelper.signIn(tester: tester, password: "");

        expect(controller.hasTriedToSignIn, false);
      });
      testWidgets('when form is valid, then sign in',
          (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        await testHelper.signIn(tester: tester);

        expect(controller.hasTriedToSignIn, true);
      });
    });
    group('given user is logging in,', () {
      testWidgets('then show login loading', (WidgetTester tester) async {
        controller.state.value.isSigningIn = true;

        await testHelper.createPage(tester, controller);

        expect(find.byKey(const Key("sign-in-loader")), findsOneWidget);
      });
      group('when login works,', () {
        testWidgets('then hide loading', (WidgetTester tester) async {
          controller.state.value.isSigningIn = false;

          await testHelper.createPage(tester, controller);

          expect(find.byKey(const Key("sign-in-loader")), findsNothing);
        });
        testWidgets('then take user to home page', (WidgetTester tester) async {
          controller.state.value.isSignedIn = true;

          await testHelper.createPage(tester, controller);
          await tester.pumpAndSettle();

          expect(testHelper.mockObserver.replacedBy, '/home');
        });
      });
    });
  });

  group('User tries to register >', () {
    testWidgets(
        'given user clicks on register button, then go to register page',
        (WidgetTester tester) async {
      await testHelper.createPage(tester, controller);

      await testHelper.clickRegisterButton(tester);

      expect(testHelper.mockObserver.navigatedTo, '/register');
    });
  });

  group('Error', () {
    testWidgets('given error, then show error', (WidgetTester tester) async {
      controller.state.value.error = ErrorModel(
        code: "anyCode",
        message: "anyMessage",
      );

      await testHelper.createPage(tester, controller);

      expect(controller.hasShowedErrorMessage, true);
    });
  });
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {
  String? navigatedTo = "";
  String? replacedBy = "";
  @override
  void didPush(Route route, Route? previousRoute) {
    navigatedTo = route.settings.name;
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    replacedBy = newRoute?.settings.name;
  }
}

class SignInControllerMock extends SignInController {
  bool hasTriedToSignIn = false;
  bool hasTriedToRecoverPassword = false;
  bool hasShowedRecoverPasswordMessage = false;
  bool hasShowedErrorMessage = false;

  SignInControllerMock() : super();

  @override
  signIn() {
    hasTriedToSignIn = true;
  }

  @override
  recoverPassword() {
    hasTriedToRecoverPassword = true;
  }

  @override
  showRecoverPasswordMessage(BuildContext context) {
    hasShowedRecoverPasswordMessage = true;
  }

  @override
  showErrorMessage(BuildContext context) {
    hasShowedErrorMessage = true;
  }
}

class TestHelper {
  late MockNavigatorObserver mockObserver;

  createPage(WidgetTester tester, SignInController? controller) async {
    mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(MaterialApp(initialRoute: '/', routes: {
      '/': (context) => SignInPage(controller: controller),
      '/register': (context) => RegisterPage(),
      '/home': (context) => const HomePage()
    }, navigatorObservers: [
      mockObserver
    ]));
  }

  clickRegisterButton(WidgetTester tester) async {
    await tester.tap(find.byKey(const Key("register-button")));
    await tester.pumpAndSettle();
  }

  clickRecoverPasswordButton(WidgetTester tester) async {
    await tester.tap(find.byKey(const Key("recover-password-button")));
    await tester.pump();
  }

  clickSignInButton(WidgetTester tester) async {
    await tester.tap(find.byKey(const Key("signin-button")));
    await tester.pump();
  }

  findEmailRequiredError() {
    return find.byKey(const Key("email-required-error"));
  }

  recoverPassword(WidgetTester tester) async {
    await setEmail(tester, "valid@email.com");
    await clickRecoverPasswordButton(tester);
  }

  toggleRevealPassword(WidgetTester tester) async {
    await tester.tap(find.byKey(const Key("reveal-password-button")));
    await tester.pumpAndSettle();
  }

  setEmail(WidgetTester tester, String value) async {
    await tester.enterText(find.bySemanticsLabel("Email"), value);
    await tester.pumpAndSettle();
  }

  setPassword(WidgetTester tester, String value) async {
    await tester.enterText(find.byKey(const Key("password")), value);
    await tester.pumpAndSettle();
  }

  signIn({
    required WidgetTester tester,
    String email = "any@email.com",
    String password = "anyPassword",
  }) async {
    await setEmail(tester, email);
    await setPassword(tester, password);
    await clickSignInButton(tester);
  }
}
