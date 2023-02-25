import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/domain/usecases/tasks/update_todo_task_usecase.dart';

part 'task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  final UpdateTodoTaskUsecase _updateTodoTaskUsecase;

  TaskDetailCubit({required UpdateTodoTaskUsecase updateTodoTaskUsecase})
      : _updateTodoTaskUsecase = updateTodoTaskUsecase,
        super(TaskDetailInitial());

  Future<void> startTask(TaskEntity? task) async {
    emit(TaskDetailLoading());

    if (task == null) {
      return emit(TaskDetailFailure(message: 'Task is empty'));
    }

    try {
      await _updateTodoTaskUsecase.execute(
        task.copyWith(startedAt: DateTime.now()),
      );
      emit(TaskDetailSuccess());
    } catch (e) {
      emit(TaskDetailFailure(message: e.toString()));
    }
  }

  Future<void> finishTask(TaskEntity? task) async {
    emit(TaskDetailLoading());

    if (task == null) {
      return emit(TaskDetailFailure(message: 'Task is empty'));
    }

    try {
      await _updateTodoTaskUsecase.execute(
        task.copyWith(finishedAt: DateTime.now()),
      );
      emit(TaskDetailSuccess());
    } catch (e) {
      emit(TaskDetailFailure(message: e.toString()));
    }
  }

  Future<void> setTaskToInProgress(TaskEntity? task) async {
    emit(TaskDetailLoading());

    if (task == null) {
      return emit(TaskDetailFailure(message: 'Task is empty'));
    }

    try {
      final item = TaskEntity(
        id: task.id,
        title: task.title,
        description: task.description,
        createdAt: task.createdAt,
        startedAt: task.startedAt,
        finishedAt: null,
      );
      await _updateTodoTaskUsecase.execute(item);
      emit(TaskDetailSuccess());
    } catch (e) {
      emit(TaskDetailFailure(message: e.toString()));
    }
  }
}
