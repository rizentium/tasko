import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'config/firebase_options.dart';
import 'core/locator/locator.dart';
import 'data/registrar.dart';
import 'domain/registrar.dart';
import 'flavors.dart';

Future<void> appInitialize() async {
  // Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  locator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);

  final registrars = [
    DataRegistrar(
      fakeIdToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.'
          'eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG'
          '9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT'
          '4fwpMeJf36POk6yJV_adQssw5c',
    ),
    DomainRegistrar(),
  ];

  await Future.wait(registrars.map((e) => e.register(locator)));
}

Future<void> main() async {
  F.appFlavor = Flavor.development;

  WidgetsFlutterBinding.ensureInitialized();
  await appInitialize();

  runApp(Application(locator: locator));
}
