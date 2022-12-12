import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  final Function(String)? onChanged;
  final GlobalKey<FormFieldState>? formKey;
  const EmailFormField({Key? key, this.onChanged, this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "seu@email.com",
        icon: Icon(Icons.person),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      validator: (email) => _validateEmail(email),
    );
  }

  _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email é obrigatório';
    }
    if (!_isEmailValid(email)) {
      return "Email é inválido";
    }
    return null;
  }

  _isEmailValid(String email) {
    if (email == "") {
      return false;
    }
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
