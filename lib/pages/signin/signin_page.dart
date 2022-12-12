import 'package:goosit/components/buttons/button_progress_indicator.dart';
import 'package:goosit/components/form-fields/email_form_field.dart';
import 'package:goosit/components/form-fields/password_form_field.dart';
import 'package:goosit/pages/signin/signin_controller.dart';
import 'package:goosit/pages/signin/signin_state.dart';
import 'package:goosit/styles/styles.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  late SignInController _controller;

  SignInPage({SignInController? controller, super.key}) {
    _controller = controller ?? SignInController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  sizedBoxSpace,
                  const Text(
                    "Goosit",
                    style: TextStyle(
                        fontSize: 48,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold),
                  ),
                  sizedBoxSpace,
                  SignInPageForm(controller: _controller),
                  sizedBoxDoubleSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignInPageForm extends StatefulWidget {
  final SignInController controller;

  const SignInPageForm({required this.controller, super.key});

  @override
  SignInPageFormState createState() {
    return SignInPageFormState(controller: controller);
  }
}

class SignInPageFormState extends State<SignInPageForm> {
  late SignInController controller;

  SignInPageFormState({required this.controller});

  final _formEmailKey = GlobalKey<FormFieldState>();
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
                _password(state),
                sizedBoxSpace,
                _recoverPasswordButton(state),
                sizedBoxFourthSpace,
                _loginButton(state),
                sizedBoxSpace,
                _registerButton(state)
              ],
            ),
          );
        });
  }

  _onStateChanges(SignInState state) {
    if (state.isSignedIn) {
      controller.goToHomePage(context);
    }
    if (state.isRecoveredPassword) {
      controller.showRecoverPasswordMessage(context);
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

  _password(SignInState state) {
    return PasswordFormField(
      key: const Key('password'),
      onChanged: (password) {
        controller.form.password = password;
      },
    );
  }

  _recoverPasswordButton(SignInState state) {
    return Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          key: const Key("recover-password-button"),
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 18),
            padding: const EdgeInsets.all(15),
          ),
          onPressed: !state.isSigningIn
              ? () async {
                  if (_formEmailKey.currentState!.validate()) {
                    await controller.recoverPassword();
                  }
                }
              : null,
          child: !state.isRecoveringPassword
              ? const Text("Recuperar senha")
              : const SizedBox(
                  height: 21,
                  width: 150,
                  child: Center(
                    child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          key: Key("recover-password-loader"),
                          strokeWidth: 2,
                        )),
                  ),
                ),
        ));
  }

  _loginButton(SignInState state) {
    return ButtonProgressIndicator(
      type: ButtonType.solid,
      isLoading: state.isSigningIn,
      label: "ENTRAR",
      onPressed: !state.isSigningIn
          ? () async {
              if (_formKey.currentState!.validate()) {
                controller.signIn();
              }
            }
          : null,
      buttonKey: const Key('signin-button'),
      indicatorKey: const Key("sign-in-loader"),
    );
  }

  _registerButton(SignInState state) {
    return TextButton(
        onPressed: !state.isSigningIn
            ? () {
                Navigator.of(context).pushNamed('/register');
              }
            : null,
        key: const Key("register-button"),
        style: buttonStyle,
        child: const Text("CADASTRAR"));
  }
}
