import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goosit/pages/home/plan_model.dart';

abstract class PlanServiceInterface {
  Future<List<PlanSummaryModel>> findPlans();
}

class PlanService implements PlanServiceInterface {
  @override
  Future<List<PlanSummaryModel>> findPlans() {
    return FirebaseFirestore.instance
        .collection("plans")
        .where("user.id", isEqualTo: "")
        .limit(20)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((e) {
        return _createPlanSummary();
      }).toList();
    });
  }

  PlanSummaryModel _createPlanSummary() {
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
