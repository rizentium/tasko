import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'config/firebase_options.dart';
import 'config/router.dart';
import 'core/locator/locator.dart';
import 'data/registrar.dart';
import 'domain/registrar.dart';
import 'flavors.dart';

Future<void> appInitialize() async {
  // Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set persistence support for firebase database
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  locator
    ..registerSingleton<FirebaseAuth>(FirebaseAuth.instance)
    ..registerSingleton<FirebaseDatabase>(FirebaseDatabase.instance);

  final registrars = [
    DataRegistrar(),
    DomainRegistrar(),
  ];

  await Future.wait(registrars.map((e) => e.register(locator)));
}

Future<void> main() async {
  F.appFlavor = Flavor.production;

  WidgetsFlutterBinding.ensureInitialized();
  await appInitialize();

  runApp(Application(router: routerConfig(locator)));
}
