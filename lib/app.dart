import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'config/router.dart';
import 'core/design_system/theme/theme.dart';

class Application extends StatelessWidget {
  final GetIt locator;
  const Application({super.key, required this.locator});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tasko',
      theme: TaskoThemes.basic,
      routerConfig: routerConfig(locator),
    );
  }
}
