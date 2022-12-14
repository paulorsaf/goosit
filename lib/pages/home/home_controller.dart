import 'package:goosit/pages/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:goosit/services/plan_service.dart';
import 'package:goosit/services/snackbar_service.dart';

class HomeController {
  late PlanServiceInterface _planService;

  final state = ValueNotifier<HomeState>(HomeState.initialState());

  HomeController({PlanServiceInterface? planService}) {
    _planService = planService ?? PlanService();
  }

  goToAddPlanPage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1), () {
      Navigator.of(context).pushReplacementNamed('/addplan');
    });
  }

  findPlans() async {
    state.value = HomeState.loadPlans();
    _planService.findPlans().then((value) {
      state.value = HomeState.loadedPlans(value);
    }).catchError((error) {
      state.value = HomeState.err(error);
    });
  }

  showErrorMessage(BuildContext context) {
    SnackbarService.showErrorMessage(
      context: context,
      error: state.value.error!,
    );
  }
}
