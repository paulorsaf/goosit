import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goosit/models/error_model.dart';

class SnackbarService {
  static showErrorMessage(
      {required BuildContext context, required ErrorModel error}) {
    Future.delayed(const Duration(milliseconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          textColor: Colors.white,
          label: "FECHAR",
          onPressed: () {},
        ),
      ));
    });
  }
}
