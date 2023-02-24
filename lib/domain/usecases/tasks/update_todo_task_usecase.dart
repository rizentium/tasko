import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/usecase.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/data/repositories/task/task.dart';

class UpdateTodoTaskUsecase implements Usecase {
  final TaskRepository _taskRepository;

  UpdateTodoTaskUsecase({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  Future<void> execute(TaskEntity entity) async {
    return await _taskRepository.update(entity);
  }

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => UpdateTodoTaskUsecase(taskRepository: locator()),
    );
  }
}
