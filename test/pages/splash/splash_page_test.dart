import 'package:goosit/pages/splash/splash_controller.dart';
import 'package:goosit/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  late SplashControllerMock controller;
  late TestHelper testHelper;

  setUp(() {
    testHelper = TestHelper();
    controller = SplashControllerMock();
  });
  testWidgets('given page starts, then find current user',
      (WidgetTester tester) async {
    await testHelper.createPage(tester, controller);

    expect(controller.hasGotCurrentUser, true);
  });
  testWidgets('given current user is logged, then send user to home page',
      (WidgetTester tester) async {
    controller.state.value.isLogged = true;

    await testHelper.createPage(tester, controller);

    expect(controller.hasGoneToHomePage, true);
  });
  testWidgets('given current user is not logged, then send user to signin page',
      (WidgetTester tester) async {
    controller.state.value.isLogged = false;

    await testHelper.createPage(tester, controller);
    await tester.pump();

    expect(controller.hasGoneToSignInPage, true);
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

class SplashControllerMock extends SplashController {
  bool hasGotCurrentUser = false;
  bool hasGoneToHomePage = false;
  bool hasGoneToSignInPage = false;

  SplashControllerMock();

  @override
  getCurrentUser() {
    hasGotCurrentUser = true;
  }

  @override
  goToHomePage(BuildContext context) {
    hasGoneToHomePage = true;
  }

  @override
  goToSignInPage(BuildContext context) {
    hasGoneToSignInPage = true;
  }
}

class TestHelper {
  late MockNavigatorObserver mockObserver;

  createPage(WidgetTester tester, SplashController controller) async {
    mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: SplashPage(controller: controller),
        navigatorObservers: [mockObserver],
      ),
    );
  }
}
