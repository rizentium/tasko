import 'package:flutter/material.dart';
import 'app.dart';
import 'core/locator/locator.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.production;
  runApp(Application(locator: locator));
}
