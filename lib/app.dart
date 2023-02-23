import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/design_system/theme/theme.dart';

class Application extends StatelessWidget {
  final GoRouter router;
  const Application({super.key, required this.router});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tasko',
      theme: TaskoThemes.basic,
      routerConfig: router,
    );
  }
}
