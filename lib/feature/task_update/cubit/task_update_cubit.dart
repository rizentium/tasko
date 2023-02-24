import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/domain/usecases/tasks/update_todo_task_usecase.dart';

part 'task_update_state.dart';

class TaskUpdateCubit extends Cubit<TaskUpdateState> {
  final UpdateTodoTaskUsecase _updateTodoTaskUsecase;
  TaskUpdateCubit({required UpdateTodoTaskUsecase updateTodoTaskUsecase})
      : _updateTodoTaskUsecase = updateTodoTaskUsecase,
        super(TaskUpdateInitial());

  Future<void> update(TaskEntity? task) async {
    emit(TaskUpdateLoading());
    if (task != null) {
      try {
        await _updateTodoTaskUsecase.execute(task);
        emit(TaskUpdateSuccess());
      } catch (e) {
        emit(TaskUpdateFailure(message: e.toString()));
      }
    } else {
      emit(const TaskUpdateFailure(message: 'Data is empty'));
    }
  }
}
