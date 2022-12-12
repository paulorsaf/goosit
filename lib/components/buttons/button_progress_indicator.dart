import 'package:goosit/styles/styles.dart';
import 'package:flutter/material.dart';

class ButtonProgressIndicator extends StatelessWidget {
  final Function()? onPressed;
  final ButtonType type;
  final bool isLoading;
  final String label;
  final Key indicatorKey;
  final Key? buttonKey;

  const ButtonProgressIndicator({
    Key? key,
    this.onPressed,
    required this.type,
    required this.isLoading,
    required this.label,
    required this.indicatorKey,
    this.buttonKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.clear) {
      return TextButton(
        key: buttonKey,
        onPressed: onPressed,
        style: buttonStyle,
        child: !isLoading ? _getText() : _getIndicator(),
      );
    }
    return ElevatedButton(
      key: buttonKey,
      onPressed: onPressed,
      style: buttonStyle,
      child: !isLoading ? _getText() : _getIndicator(),
    );
  }

  _getIndicator() {
    return SizedBox(
      height: 28,
      width: 28,
      child: CircularProgressIndicator(
        key: indicatorKey,
        strokeWidth: 2,
        color: type == ButtonType.solid ? Colors.white : Colors.teal,
      ),
    );
  }

  _getText() {
    return Text(label);
  }
}

enum ButtonType { solid, clear }
