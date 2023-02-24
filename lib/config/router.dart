import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/feature/create_task/route/create_task.dart';
import 'package:tasko/feature/create_task/screen/create_task.dart';
import 'package:tasko/feature/dashboard/screen/dashboard.dart';
import 'package:tasko/feature/login/route/login.dart';
import 'package:tasko/feature/profile/screen/profile.dart';
import 'package:tasko/feature/task_detail/route/task_detail.dart';

import '../feature/home/route/home.dart';

GoRouter routerConfig(GetIt locator) {
  return GoRouter(
    routes: [
      HomeRoute(
        onUnauthorizedUrl: LoginRoute.path,
        createTaskUrl: CreateTaskRoute.path,
        getUserUsecase: locator(),
        profileScreen: ProfileScreen(
          signOutUserUsecase: locator(),
          onSignedOutUrl: LoginRoute.path,
        ),
        dashboardScreen: DashboardScreen(
          streamTodoTaskUsecase: locator(),
          taskDetailUrl: TaskDetailRoute.path,
        ),
      ).route,
      LoginRoute(
        signInUserUsecase: locator(),
        onSuccessUrl: HomeRoute.path,
      ).route,
      CreateTaskRoute(createTodoTaskUsecase: locator()).route,
      TaskDetailRoute().route,
    ],
    initialLocation: HomeRoute.path,
  );
}
