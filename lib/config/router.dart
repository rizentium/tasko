import 'package:go_router/go_router.dart';

import '../feature/home/route/home.dart';

final routerConfig = GoRouter(
  routes: [
    HomeRoute.route,
  ],
  initialLocation: HomeRoute.path,
);
