import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/registrar.dart';
import 'package:tasko/domain/usecases/registrar.dart';

class DomainRegistrar implements Registrar {
  final registrar = [
    UsecaseRegistrar(),
  ];

  @override
  Future<void> register(GetIt locator) async {
    await Future.wait(registrar.map((e) => e.register(locator)));
  }
}
