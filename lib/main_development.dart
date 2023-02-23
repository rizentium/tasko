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
  const fakeIdToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY'
      '3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2Q'
      'T4fwpMeJf36POk6yJV_adQssw5c';
  const emulatorUrl = '10.0.2.2';

  // Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  locator
    ..registerSingleton<FirebaseAuth>(FirebaseAuth.instance)
    ..registerSingleton<FirebaseDatabase>(FirebaseDatabase.instance);

  FirebaseAuth.instance.useAuthEmulator(emulatorUrl, 9099);
  FirebaseDatabase.instance.useDatabaseEmulator(emulatorUrl, 9000);

  final registrars = [
    DataRegistrar(fakeIdToken: fakeIdToken),
    DomainRegistrar(),
  ];

  await Future.wait(registrars.map((e) => e.register(locator)));
}

Future<void> main() async {
  F.appFlavor = Flavor.development;

  WidgetsFlutterBinding.ensureInitialized();
  await appInitialize();

  runApp(Application(router: routerConfig(locator)));
}
