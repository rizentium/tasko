import 'package:flutter/material.dart';
import 'app.dart';
import 'config/router.dart';
import 'core/locator/locator.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.production;
  runApp(Application(router: routerConfig(locator)));
}
