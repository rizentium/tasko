import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/locator/route.dart';
import 'package:tasko/core/mixin/transition_builder.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/feature/task_detail/screen/task_detail.dart';

class TaskDetailRoute with TransitionBuilderMixin implements RouteRegistrar {
  static String path = '/task-detail';

  TaskDetailRoute();

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => const TaskDetailScreen(),
    );
  }

  @override
  GoRoute get route {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) {
        final task = state.extra as TaskEntity?;
        return CustomTransitionPage(
          child: TaskDetailScreen(task: task),
          transitionsBuilder: bottomToUpTransition,
        );
      },
    );
  }
}
