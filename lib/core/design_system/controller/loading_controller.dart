import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoadingController {
  final BuildContext context;

  LoadingController(this.context);

  show() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 24),
              Text('Loading'),
            ],
          ),
        );
      },
    );
  }

  dismiss() => context.pop();
}
