import 'package:goosit/models/error_model.dart';
import 'package:goosit/pages/home/plan_model.dart';

class HomeState {
  ErrorModel? error;
  bool isLoadedPlans;
  bool isLoadingPlans;
  List<PlanSummaryModel> planSummaries = List<PlanSummaryModel>.empty();

  HomeState({
    required this.isLoadedPlans,
    required this.isLoadingPlans,
    required this.planSummaries,
    this.error,
  });

  static initialState() {
    return HomeState(
      isLoadedPlans: false,
      isLoadingPlans: false,
      planSummaries: List<PlanSummaryModel>.empty(),
      error: null,
    );
  }

  static loadPlans() {
    return HomeState(
      isLoadedPlans: false,
      isLoadingPlans: true,
      planSummaries: List<PlanSummaryModel>.empty(),
      error: null,
    );
  }

  static loadedPlans(List<PlanSummaryModel> planSummaries) {
    return HomeState(
      isLoadedPlans: true,
      isLoadingPlans: false,
      planSummaries: planSummaries,
      error: null,
    );
  }

  static err(ErrorModel error) {
    return HomeState(
      isLoadedPlans: false,
      isLoadingPlans: false,
      planSummaries: List<PlanSummaryModel>.empty(),
      error: error,
    );
  }
}
