import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/registrar.dart';
import 'package:tasko/data/repositories/registrar.dart';

class DataRegistrar implements Registrar {
  final registrars = [
    RepositoryRegistrar(),
  ];
  @override
  Future<void> register(GetIt locator) async {
    await Future.wait(registrars.map((e) => e.register(locator)));
  }
}
