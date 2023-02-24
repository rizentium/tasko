import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/locator/route.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/domain/usecases/tasks/update_todo_task_usecase.dart';
import 'package:tasko/feature/task_update/screen/task_update.dart';

class TaskUpdateRoute implements RouteRegistrar {
  final UpdateTodoTaskUsecase _updateTodoTaskUsecase;
  final void Function(BuildContext context) onSuccess;

  TaskUpdateRoute({
    required UpdateTodoTaskUsecase updateTodoTaskUsecase,
    required this.onSuccess,
  }) : _updateTodoTaskUsecase = updateTodoTaskUsecase;

  static String path = '/task-update';

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(() => TaskUpdateScreen(
          updateTodoTaskUsecase: _updateTodoTaskUsecase,
          onSuccess: onSuccess,
        ));
  }

  @override
  GoRoute get route {
    return GoRoute(
      path: path,
      builder: (context, state) {
        final task = state.extra as TaskEntity?;
        return TaskUpdateScreen(
          task: task,
          updateTodoTaskUsecase: _updateTodoTaskUsecase,
          onSuccess: onSuccess,
        );
      },
    );
  }
}
