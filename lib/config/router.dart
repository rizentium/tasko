import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/feature/login/route/login.dart';

import '../feature/home/route/home.dart';

routerConfig(GetIt locator) {
  return GoRouter(
    routes: [
      HomeRoute(
        onUnauthorized: (context) => context.go(LoginRoute.path),
        getUserUsecase: locator(),
      ).route,
      LoginRoute(
        signInUserUsecase: locator(),
        onSuccess: (context) => context.go(HomeRoute.path),
      ).route,
    ],
    initialLocation: HomeRoute.path,
  );
}
