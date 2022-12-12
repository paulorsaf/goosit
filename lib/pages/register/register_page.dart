import 'package:goosit/components/buttons/button_progress_indicator.dart';
import 'package:goosit/components/form-fields/email_form_field.dart';
import 'package:goosit/components/form-fields/password_form_field.dart';
import 'package:goosit/pages/register/register_controller.dart';
import 'package:goosit/pages/register/register_state.dart';
import 'package:goosit/styles/styles.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  late RegisterController _controller;
  final appBar = AppBar(title: const Text("Cadastrar"));

  RegisterPage({RegisterController? controller, super.key}) {
    _controller = controller ?? RegisterController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('register-page'),
      appBar: appBar,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height -
                  appBar.preferredSize.height),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _title(),
                  sizedBoxSpace,
                  RegisterPageForm(
                    controller: _controller,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _title() {
    return const Text(
      "Goosit",
      style: TextStyle(
        fontSize: 48,
        color: Colors.teal,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class RegisterPageForm extends StatefulWidget {
  late RegisterController controller;

  RegisterPageForm({required this.controller, super.key});

  @override
  State<RegisterPageForm> createState() =>
      _RegisterPageFormState(controller: controller);
}

class _RegisterPageFormState extends State<RegisterPageForm> {
  late RegisterController controller;

  _RegisterPageFormState({required this.controller});

  final _formEmailKey = GlobalKey<FormFieldState>();
  final _formPasswordKey = GlobalKey<FormFieldState>();
  final _formConfirmPasswordKey = GlobalKey<FormFieldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.state,
        builder: (context, state, child) {
          _onStateChanges(state);
          return Form(
            key: _formKey,
            child: Column(
              children: [
                _email(),
                sizedBoxSpace,
                _password(),
                sizedBoxSpace,
                _repeatPassword(),
                sizedBoxFourthSpace,
                _register(),
                sizedBoxSpace,
                _signIn(),
                sizedBoxFourthSpace,
              ],
            ),
          );
        });
  }

  _onStateChanges(RegisterState state) {
    if (state.isRegistered) {
      controller.goToHomePage(context);
    }
    if (state.error != null) {
      controller.showErrorMessage(context);
    }
  }

  _email() {
    return EmailFormField(
        formKey: _formEmailKey,
        onChanged: (email) {
          controller.form.email = email;
        });
  }

  _password() {
    return PasswordFormField(
      key: const Key('password'),
      formKey: _formPasswordKey,
      onChanged: (password) {
        controller.form.password = password;
      },
    );
  }

  _repeatPassword() {
    return PasswordFormField(
      key: const Key('confirm-password'),
      formKey: _formConfirmPasswordKey,
      labelText: "Confirmar senha",
      onChanged: (password) {
        controller.form.repeatPassword = password;
      },
      hasToBeEqualTo: _formPasswordKey,
    );
  }

  _register() {
    return ButtonProgressIndicator(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          controller.register();
        }
      },
      indicatorKey: const Key("register-loader"),
      isLoading: controller.state.value.isRegistering,
      label: "CADASTRAR",
      type: ButtonType.solid,
      buttonKey: const Key("register-button"),
    );
  }

  _signIn() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: buttonStyle,
      child: const Text("ENTRAR"),
    );
  }
}
