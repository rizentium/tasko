import 'package:flutter/material.dart';
import 'package:tasko/config/locator.dart';
import 'app.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.production;
  runApp(Application(locator: locator));
}
