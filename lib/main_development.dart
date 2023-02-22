import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'config/firebase_options.dart';
import 'core/locator/locator.dart';
import 'data/registrar.dart';
import 'domain/registrar.dart';
import 'feature/registrar.dart';
import 'flavors.dart';

Future<void> appInitialize() async {
  final registrars = [
    DataRegistrar(),
    DomainRegistrar(),
    FeatureRegistrar(),
  ];

  locator
    ..registerSingleton<FirebaseApp>(
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
    )
    ..registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);

  await Future.wait(registrars.map((e) => e.register(locator)));
}

Future<void> main() async {
  F.appFlavor = Flavor.development;

  WidgetsFlutterBinding.ensureInitialized();
  await appInitialize();

  runApp(Application(locator: locator));
}
