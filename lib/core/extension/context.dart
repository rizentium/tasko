import 'package:flutter/material.dart';

extension BuildContextExtended on BuildContext {
  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
    required String message,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
