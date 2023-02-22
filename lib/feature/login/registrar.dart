import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/feature.dart';
import 'package:tasko/feature/login/route/login.dart';

class LoginFeatureRegistrar implements Feature {
  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(() => LoginRoute());
  }
}
