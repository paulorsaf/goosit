import 'package:goosit/models/error_model.dart';
import 'package:goosit/pages/home/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goosit/pages/home/plan_model.dart';

void main() {
  test('given initial state, then validate state', () async {
    HomeState state = HomeState.initialState();

    expect(state.error, null);
    expect(state.isLoadedPlans, false);
    expect(state.isLoadingPlans, false);
    expect(state.planSummaries.length, 0);
  });
  test('given load plans, then validate state', () async {
    HomeState state = HomeState.loadPlans();

    expect(state.error, null);
    expect(state.isLoadedPlans, false);
    expect(state.isLoadingPlans, true);
    expect(state.planSummaries, List<PlanSummaryModel>.empty());
  });
  test('given loaded plans, then validate state', () async {
    List<PlanSummaryModel> planSummaries = List.filled(
      3,
      PlanSummaryModel(
        amountOfCities: 2,
        amountOfCountries: 1,
        createdAt: "createdAt",
        endsAt: "endsAt",
        id: "anyId",
        startsAt: "startsAt",
        title: "anytitle",
      ),
    );

    HomeState state = HomeState.loadedPlans(planSummaries);

    expect(state.error, null);
    expect(state.isLoadedPlans, true);
    expect(state.isLoadingPlans, false);
    expect(state.planSummaries, planSummaries);
  });
  test('given error on loading plans, then validate state', () async {
    ErrorModel error = ErrorModel(code: "anyCode", message: "anyMessage");

    HomeState state = HomeState.err(error);

    expect(state.error, error);
    expect(state.isLoadedPlans, false);
    expect(state.isLoadingPlans, false);
    expect(state.planSummaries.length, 0);
  });
}
