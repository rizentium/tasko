import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/data/entities/task_tracker.dart';
import 'package:tasko/domain/usecases/tasks/update_todo_task_usecase.dart';

part 'task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  final UpdateTodoTaskUsecase _updateTodoTaskUsecase;

  TaskDetailCubit({required UpdateTodoTaskUsecase updateTodoTaskUsecase})
      : _updateTodoTaskUsecase = updateTodoTaskUsecase,
        super(TaskDetailInitial());

  void initialize(TaskEntity? task) {
    emit(TaskDetailSuccess(data: task));
  }

  Future<void> startTask(TaskEntity? task) async {
    emit(TaskDetailLoading(data: state.data));

    if (task == null) {
      return emit(TaskDetailFailure(
        data: state.data,
        message: 'Task is empty',
      ));
    }

    try {
      await _updateTodoTaskUsecase.execute(
        task.copyWith(startedAt: DateTime.now()),
      );
      emit(TaskDetailSuccess(data: state.data));
    } catch (e) {
      emit(TaskDetailFailure(message: e.toString()));
    }
  }

  Future<void> finishTask(TaskEntity? task) async {
    emit(TaskDetailLoading(data: state.data));

    if (task == null) {
      return emit(TaskDetailFailure(
        data: state.data,
        message: 'Task is empty',
      ));
    }

    try {
      await _updateTodoTaskUsecase.execute(
        task.copyWith(finishedAt: DateTime.now()),
      );
      emit(TaskDetailSuccess(data: state.data));
    } catch (e) {
      emit(TaskDetailFailure(message: e.toString()));
    }
  }

  Future<void> setTaskToInProgress(TaskEntity? task) async {
    emit(TaskDetailLoading(data: state.data));

    if (task == null) {
      return emit(TaskDetailFailure(
        data: state.data,
        message: 'Task is empty',
      ));
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
      emit(TaskDetailSuccess(data: state.data));
    } catch (e) {
      emit(TaskDetailFailure(message: e.toString()));
    }
  }

  Future<void> onTracking({
    TaskEntity? task,
    required TaskTrackerType type,
  }) async {
    emit(TaskDetailLoading(data: state.data));

    if (task == null) {
      return emit(TaskDetailFailure(
        data: state.data,
        message: 'Task is empty',
      ));
    }

    try {
      final item = task.copyWith(
        trackers: task.trackers
          ?..add(TaskTracker(point: DateTime.now(), type: type)),
      );

      await _updateTodoTaskUsecase.execute(item);

      final message = type == TaskTrackerType.started
          ? 'Time Tracker started'
          : 'Time Tracker stopped';
      emit(TaskDetailTracking(data: item, message: message));
    } catch (e) {
      emit(TaskDetailFailure(data: state.data, message: e.toString()));
    }
  }
}
