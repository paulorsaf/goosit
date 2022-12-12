import 'dart:async';

import 'package:goosit/pages/home/plan_model.dart';

abstract class PlanServiceInterface {
  Future<List<PlanSummaryModel>> findPlans();
}

class PlanService implements PlanServiceInterface {
  @override
  Future<List<PlanSummaryModel>> findPlans() {
    return Future.delayed(const Duration(seconds: 2)).then((_) {
      return Future.value(
          List<PlanSummaryModel>.filled(2, _createPlanSummary()));
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
}
