import 'package:flutter/material.dart';

import 'config/router.dart';
import 'core/design_system/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tasko',
      theme: TaskoThemes.basic,
      routerConfig: routerConfig,
    );
  }
}
