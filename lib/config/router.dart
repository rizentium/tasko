import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/feature/login/route/login.dart';
import 'package:tasko/feature/profile/screen/profile.dart';

import '../feature/home/route/home.dart';

routerConfig(GetIt locator) {
  return GoRouter(
    routes: [
      HomeRoute(
        onUnauthorized: (context) => context.go(LoginRoute.path),
        getUserUsecase: locator(),
        profileScreen: ProfileScreen(
          signOutUserUsecase: locator(),
          onSignedOut: (context) => context.go(
            LoginRoute.path,
          ),
        ),
      ).route,
      LoginRoute(
        signInUserUsecase: locator(),
        onSuccess: (context) => context.go(HomeRoute.path),
      ).route,
    ],
    initialLocation: HomeRoute.path,
  );
}
