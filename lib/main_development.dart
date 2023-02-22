import 'package:flutter/material.dart';
import 'package:tasko/config/locator.dart';
import 'app.dart';
import 'flavors.dart';

Future<void> main() async {
  F.appFlavor = Flavor.development;

  WidgetsFlutterBinding.ensureInitialized();
  await initialize();

  runApp(Application(locator: locator));
}
