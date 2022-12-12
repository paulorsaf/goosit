import 'package:goosit/pages/splash/splash_controller.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  late SplashController _controller;
  SplashPage({SplashController? controller, super.key}) {
    _controller = controller ?? SplashController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashPageState(controller: _controller),
    );
  }
}

class SplashPageState extends StatefulWidget {
  late SplashController _controller;
  SplashPageState({SplashController? controller, super.key}) {
    _controller = controller ?? SplashController();
  }

  @override
  State<SplashPageState> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPageState> {
  @override
  Widget build(BuildContext context) {
    widget._controller.getCurrentUser();

    return ValueListenableBuilder(
      builder: (context, value, child) {
        if (value.isLogged == true) {
          widget._controller.goToHomePage(context);
        } else if (value.isLogged == false) {
          widget._controller.goToSignInPage(context);
        }
        return const Center(child: CircularProgressIndicator());
      },
      valueListenable: widget._controller.state,
    );
  }
}
