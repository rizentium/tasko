import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/locator/route.dart';
import 'package:tasko/core/mixin/transition_builder.dart';
import 'package:tasko/domain/usecases/tasks/create_todo_task_usecase.dart';
import 'package:tasko/feature/task_create/screen/task_create.dart';

class TaskCreateRoute with TransitionBuilderMixin implements RouteRegistrar {
  final CreateTodoTaskUsecase _createTodoTaskUsecase;

  static String path = '/task-create';

  TaskCreateRoute({required CreateTodoTaskUsecase createTodoTaskUsecase})
      : _createTodoTaskUsecase = createTodoTaskUsecase;

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => TaskCreateScreen(createTodoTaskUsecase: locator()),
    );
  }

  @override
  GoRoute get route {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: TaskCreateScreen(
          createTodoTaskUsecase: _createTodoTaskUsecase,
        ),
        transitionsBuilder: bottomToUpTransition,
      ),
    );
  }
}
