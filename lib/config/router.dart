import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/feature/dashboard/screen/dashboard.dart';
import 'package:tasko/feature/home/route/home.dart';
import 'package:tasko/feature/login/route/login.dart';
import 'package:tasko/feature/profile/screen/profile.dart';
import 'package:tasko/feature/task_create/route/task_create.dart';
import 'package:tasko/feature/task_detail/route/task_detail.dart';
import 'package:tasko/feature/task_update/route/task_update.dart';

GoRouter routerConfig(GetIt locator) {
  return GoRouter(
    routes: [
      HomeRoute(
        onUnauthorizedUrl: LoginRoute.path,
        createTaskUrl: TaskCreateRoute.path,
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
      TaskCreateRoute(createTodoTaskUsecase: locator()).route,
      TaskDetailRoute(
        taskUpdateUrl: TaskUpdateRoute.path,
        onSuccessUpdateUrl: HomeRoute.path,
        updateTodoTaskUsecase: locator(),
      ).route,
      TaskUpdateRoute(
        updateTodoTaskUsecase: locator(),
        onSuccess: (context) => context.go(HomeRoute.path),
      ).route,
    ],
    initialLocation: HomeRoute.path,
  );
}
