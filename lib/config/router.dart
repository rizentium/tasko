import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/feature/login/route/login.dart';

import '../feature/home/route/home.dart';

routerConfig(GetIt locator) {
  return GoRouter(
    routes: [
      HomeRoute(
        getUserUsecase: locator(),
        loginRoute: locator(),
      ).route,
      LoginRoute().route,
    ],
    initialLocation: HomeRoute(
      getUserUsecase: locator(),
      loginRoute: locator(),
    ).path,
  );
}
