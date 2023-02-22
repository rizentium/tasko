import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/registrar.dart';
import 'package:tasko/data/repositories/registrar.dart';

class DataRegistrar implements Registrar {
  final String? fakeIdToken;

  DataRegistrar({this.fakeIdToken});

  @override
  Future<void> register(GetIt locator) async {
    final registrars = [
      RepositoryRegistrar(fakeIdToken: fakeIdToken),
    ];

    await Future.wait(registrars.map((e) => e.register(locator)));
  }
}
