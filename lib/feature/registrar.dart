import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/registrar.dart';
import 'package:tasko/feature/home/registrar.dart';
import 'package:tasko/feature/login/registrar.dart';

class FeatureRegistrar implements Registrar {
  final features = [
    LoginFeatureRegistrar(),
    HomeFeatureRegistrar(),
  ];

  @override
  Future<void> register(GetIt locator) async {
    await Future.wait(features.map((e) => e.register(locator)));
  }
}
