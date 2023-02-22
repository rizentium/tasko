import 'package:get_it/get_it.dart';
import 'package:tasko/data/registrar.dart';
import 'package:tasko/domain/registrar.dart';
import 'package:tasko/feature/registrar.dart';

final locator = GetIt.instance;

Future<void> initialize() async {
  final registrars = [
    DataRegistrar(),
    DomainRegistrar(),
    FeatureRegistrar(),
  ];

  await Future.wait(registrars.map((e) => e.register(locator)));
}
