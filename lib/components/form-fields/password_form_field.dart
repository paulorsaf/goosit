import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final Function(String)? onChanged;

  final GlobalKey<FormFieldState>? formKey;
  final bool? initialVisibility;
  final String? labelText;
  final GlobalKey<FormFieldState>? hasToBeEqualTo;

  const PasswordFormField({
    Key? key,
    this.onChanged,
    this.formKey,
    this.initialVisibility,
    this.labelText = "Senha",
    this.hasToBeEqualTo,
  }) : super(key: key);

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _revealPassword = false;
  @override
  void initState() {
    super.initState();
    _revealPassword = widget.initialVisibility ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: widget.formKey,
      decoration: InputDecoration(
        labelText: widget.labelText,
        icon: const Icon(Icons.lock),
        suffix: TextButton(
          key: const Key('reveal-password-button'),
          onPressed: () {
            setState(() {
              _revealPassword = !_revealPassword;
            });
          },
          child: !_revealPassword
              ? const Icon(
                  Icons.visibility,
                  key: Key('visibility-on'),
                )
              : const Icon(
                  Icons.visibility_off,
                  key: Key('visibility-off'),
                ),
        ),
      ),
      obscureText: !_revealPassword,
      onChanged: widget.onChanged,
      validator: (password) => _validatePassword(password),
    );
  }

  _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (widget.hasToBeEqualTo?.currentState?.value != null) {
      if (password.compareTo(widget.hasToBeEqualTo?.currentState?.value) != 0) {
        return "Confirmar senha e Senha devem ser iguais";
      }
    }
    return null;
  }
}
