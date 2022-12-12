import 'package:goosit/models/error_model.dart';
import 'package:goosit/pages/home/home_controller.dart';
import 'package:goosit/pages/home/plan_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goosit/services/plan_service.dart';
import 'package:mockito/mockito.dart';

class PlanServiceMock extends Mock implements PlanServiceInterface {
  late ErrorModel? error;
  late Future<List<PlanSummaryModel>> findPlansResponse;
  PlanServiceMock() {
    error = null;
  }

  @override
  Future<List<PlanSummaryModel>> findPlans() {
    if (error != null) {
      return Future<List<PlanSummaryModel>>.error(error!);
    }
    return findPlansResponse;
  }
}

void main() {
  PlanServiceMock planService = PlanServiceMock();
  HomeController controller = HomeController(planService: planService);
  group('Find plans > ', () {
    group('given find plans, ', () {
      test('then start loading plans', () async {
        planService.findPlansResponse = Future<List<PlanSummaryModel>>.delayed(
            const Duration(seconds: 10000), () {
          return List<PlanSummaryModel>.empty();
        });

        controller.findPlans();

        expect(controller.state.value.isLoadingPlans, true);
      });
      group('when plans loaded', () {
        PlanSummaryModel planSummaryModel = PlanSummaryModel(
          amountOfCities: 2,
          amountOfCountries: 1,
          createdAt: "createdAt",
          endsAt: "endsAt",
          id: "anyId",
          startsAt: "startsAt",
          title: "anytitle",
        );
        List<PlanSummaryModel> plans =
            List<PlanSummaryModel>.filled(2, planSummaryModel);

        setUp(() {
          planService.findPlansResponse =
              Future<List<PlanSummaryModel>>.value(plans);
        });

        test('then set plans', () async {
          await controller.findPlans();

          expect(controller.state.value.planSummaries, plans);
        });
        test('then set plans as loaded', () async {
          await controller.findPlans();

          expect(controller.state.value.isLoadedPlans, true);
        });
      });
      group('when error on loading plans', () {
        ErrorModel error = ErrorModel(code: "anyCode", message: "anyMessage");
        setUp(() {
          planService.error = error;
        });

        test('then set error', () async {
          await controller.findPlans();

          expect(controller.state.value.error, error);
        });
        test('then set plans as not loaded', () async {
          await controller.findPlans();

          expect(controller.state.value.isLoadedPlans, false);
        });
      });
    });
  });
}
