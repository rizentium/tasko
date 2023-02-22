import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/feature.dart';
import 'package:tasko/feature/home/route/home.dart';

class HomeFeatureRegistrar implements Feature {
  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => HomeRoute(getUserUsecase: locator(), loginRoute: locator()),
    );
  }
}
