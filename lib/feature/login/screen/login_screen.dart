import 'package:flutter/material.dart';
import 'package:tasko/core/extensions/context.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'tasko',
              style: context.textTheme.displaySmall?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            const Text('Put every notes in single app'),
          ],
        ),
      ),
    );
  }
}
