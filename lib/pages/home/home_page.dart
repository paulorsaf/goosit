import 'package:flutter/material.dart';
import 'package:goosit/components/side-menu/side_menu.dart';
import 'package:goosit/pages/home/home_controller.dart';
import 'package:goosit/pages/home/plan_model.dart';

class HomePage extends StatelessWidget {
  late HomeController _controller;

  HomePage({HomeController? controller, super.key}) {
    _controller = controller ?? HomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus planos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: TravelPlans(controller: _controller),
      ),
      drawer: const SideMenu(),
      floatingActionButton: FloatingActionButton(
        key: const Key("add-plan-button"),
        onPressed: () {
          _controller.goToAddPlanPage(context);
        },
        tooltip: "Adicionar plano",
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TravelPlans extends StatefulWidget {
  final HomeController controller;

  const TravelPlans({required this.controller, Key? key});

  @override
  _TravelPlansState createState() => _TravelPlansState();
}

class _TravelPlansState extends State<TravelPlans> {
  @override
  void initState() {
    super.initState();

    widget.controller.findPlans();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller.state,
      builder: (context, state, child) {
        if (state.error != null) {
          widget.controller.showErrorMessage(context);
        }

        if (state.isLoadingPlans) {
          return _loading();
        }
        if (state.planSummaries.isEmpty) {
          return const NoPlansFound();
        }
        return _planList(state.planSummaries);
      },
    );
  }

  _planList(List<PlanSummaryModel> planSummaries) {
    return Column(
      key: const Key('plans'),
      children: planSummaries.map((e) => const TravelCard()).toList(),
    );
  }

  _loading() {
    return const Center(
      child: CircularProgressIndicator(
        key: Key("plans-loader"),
      ),
    );
  }
}

class NoPlansFound extends StatelessWidget {
  const NoPlansFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Nenhum plano encontrado",
        key: const Key("no-results-found"),
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class TravelCard extends StatelessWidget {
  const TravelCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: InkWell(
        splashColor: Colors.teal.withAlpha(50),
        onTap: () {},
        child: Column(
          children: const [
            SectionTitle(
              title: "Título da viagem",
            ),
            SectionBody(),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class SectionBody extends StatelessWidget {
  const SectionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "De 16/12/2022 até 14/01/2023",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "10 cidades em 1 país",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            heightFactor: 2,
            child: Text(
              "Criado em 01/12/2022",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        ],
      ),
    );
  }
}
