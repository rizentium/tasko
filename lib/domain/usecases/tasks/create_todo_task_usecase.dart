import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/usecase.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/data/repositories/task/task.dart';

class CreateTodoTaskUsecase implements Usecase {
  final TaskRepository _taskRepository;

  CreateTodoTaskUsecase({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  Future<void> execute(TaskEntity entity) async {
    return await _taskRepository.create(entity);
  }

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => CreateTodoTaskUsecase(taskRepository: locator()),
    );
  }
}
