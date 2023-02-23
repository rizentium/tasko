import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/domain/usecases/tasks/get_todo_task_usecase.dart';

part 'dashboard_todo_state.dart';

class DashboardTodoCubit extends Cubit<DashboardTodoState> {
  final GetTodoTaskUsecase _getTodoTaskUsecase;

  DashboardTodoCubit({required GetTodoTaskUsecase getTodoTaskUsecase})
      : _getTodoTaskUsecase = getTodoTaskUsecase,
        super(DashboardTodoInitial());

  Future<void> initialize() async {
    emit(DashboardTodoLoading());

    try {
      final data = await _getTodoTaskUsecase.execute();
      emit(DashboardTodoSuccess(data: data));
    } catch (_) {
      emit(const DashboardTodoFailure(message: 'Ops. Something happened!'));
    }
  }
}