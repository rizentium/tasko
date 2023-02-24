import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/locator/route.dart';
import 'package:tasko/core/mixin/transition_builder.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/feature/task_detail/screen/task_detail.dart';

class TaskDetailRoute with TransitionBuilderMixin implements RouteRegistrar {
  final String taskUpdateUrl;
  static String path = '/task-detail';

  TaskDetailRoute({required this.taskUpdateUrl});

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => TaskDetailScreen(taskUpdateUrl: taskUpdateUrl),
    );
  }

  @override
  GoRoute get route {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) {
        final task = state.extra as TaskEntity?;
        return CustomTransitionPage(
          child: TaskDetailScreen(task: task, taskUpdateUrl: taskUpdateUrl),
          transitionsBuilder: bottomToUpTransition,
        );
      },
    );
  }
}
