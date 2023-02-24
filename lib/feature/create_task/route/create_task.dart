import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/locator/route.dart';
import 'package:tasko/core/mixin/transition_builder.dart';
import 'package:tasko/domain/usecases/tasks/create_todo_task_usecase.dart';
import 'package:tasko/feature/create_task/screen/create_task.dart';

class CreateTaskRoute with TransitionBuilderMixin implements RouteRegistrar {
  final CreateTodoTaskUsecase _createTodoTaskUsecase;

  static String path = '/task-create';

  CreateTaskRoute({required CreateTodoTaskUsecase createTodoTaskUsecase})
      : _createTodoTaskUsecase = createTodoTaskUsecase;

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => CreateTaskScreen(createTodoTaskUsecase: locator()),
    );
  }

  @override
  GoRoute get route {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: CreateTaskScreen(
          createTodoTaskUsecase: _createTodoTaskUsecase,
        ),
        transitionsBuilder: bottomToUpTransition,
      ),
    );
  }
}
