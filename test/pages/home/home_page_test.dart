import 'package:goosit/models/error_model.dart';
import 'package:goosit/pages/home/home_controller.dart';
import 'package:goosit/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goosit/pages/home/plan_model.dart';

import '../splash/splash_page_test.dart';

void main() {
  late HomeControllerMock controller;
  late TestHelper testHelper;

  setUp(() {
    testHelper = TestHelper();
    controller = HomeControllerMock();
  });

  group('User enters page', () {
    group('given page started,', () {
      testWidgets('then load travel plans', (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        expect(controller.hasSearchedPlans, true);
      });
    });
    group('given loading travel plans,', () {
      setUp(() {
        controller.state.value.isLoadingPlans = true;
      });
      testWidgets('then show plans loader', (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        expect(find.byKey(const Key("plans-loader")), findsOneWidget);
      });
      testWidgets('then hide plans', (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        expect(find.byKey(const Key("plans")), findsNothing);
      });
    });
    group('given travel plans loaded,', () {
      setUp(() {
        controller.state.value.isLoadingPlans = false;
        controller.state.value.isLoadedPlans = true;
        controller.state.value.planSummaries =
            List<PlanSummaryModel>.filled(3, _createPlanSummary());
      });
      testWidgets('then hide plans loader', (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        expect(find.byKey(const Key("plans-loader")), findsNothing);
      });
      testWidgets('then show plans', (WidgetTester tester) async {
        await testHelper.createPage(tester, controller);

        expect(find.byType(TravelCard), findsNWidgets(3));
      });
      group('when no travel plans loaded,', () {
        setUp(() {
          controller.state.value.planSummaries = List<PlanSummaryModel>.empty();
        });
        testWidgets('then hide plans', (WidgetTester tester) async {
          await testHelper.createPage(tester, controller);

          expect(find.byType(TravelCard), findsNothing);
        });
        testWidgets('then show no results found message',
            (WidgetTester tester) async {
          await testHelper.createPage(tester, controller);

          expect(find.byKey(const Key("no-results-found")), findsOneWidget);
        });
      });
    });
    group('given error,', () {
      testWidgets('then show error', (WidgetTester tester) async {
        controller.state.value.error =
            ErrorModel(code: "anycode", message: "anyError");

        await testHelper.createPage(tester, controller);

        expect(controller.hasShowedErrorMessage, true);
      });
    });
  });
}

_createPlanSummary() {
  return PlanSummaryModel(
    amountOfCities: 2,
    amountOfCountries: 1,
    createdAt: "createdAt",
    endsAt: "endsAt",
    id: "anyId",
    startsAt: "startsAt",
    title: "anytitle",
  );
}

class HomeControllerMock extends HomeController {
  bool hasSearchedPlans = false;
  bool hasShowedErrorMessage = false;

  HomeControllerMock();

  @override
  findPlans() {
    hasSearchedPlans = true;
  }

  @override
  showErrorMessage(BuildContext context) {
    hasShowedErrorMessage = true;
  }
}

class TestHelper {
  late MockNavigatorObserver mockObserver;

  createPage(WidgetTester tester, HomeController? controller) async {
    mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/',
        routes: {'/': (context) => HomePage(controller: controller)},
        navigatorObservers: [mockObserver],
      ),
    );
  }
}
