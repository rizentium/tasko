import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/usecase.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/data/repositories/task/task.dart';

class GetTodoTaskUsecase implements Usecase<Future<List<TaskEntity>>> {
  final TaskRepository _taskRepository;

  GetTodoTaskUsecase({required TaskRepository taskRepository})
      : _taskRepository = taskRepository;

  @override
  execute() => _taskRepository.read();

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => GetTodoTaskUsecase(taskRepository: _taskRepository),
    );
  }
}
