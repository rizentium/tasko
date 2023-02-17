import 'package:flutter/material.dart';

import 'core/design_system/theme/theme.dart';
import 'feature/home/screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasko',
      theme: TaskoThemes.basic,
      home: const HomeScreen(),
    );
  }
}
