import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/domain/usecases/tasks/stream_todo_task_usecase.dart';

part 'dashboard_todo_state.dart';

class DashboardTodoCubit extends Cubit<DashboardTodoState> {
  final StreamTodoTaskUsecase _streamTodoTaskUsecase;

  DashboardTodoCubit({required StreamTodoTaskUsecase streamTodoTaskUsecase})
      : _streamTodoTaskUsecase = streamTodoTaskUsecase,
        super(DashboardTodoInitial());

  Future<void> initialize() async {
    emit(DashboardTodoLoading());

    try {
      final data = _streamTodoTaskUsecase.execute().asyncMap<List<TaskEntity>>(
            (event) => event
                .where((e) => e.startedAt == null)
                .sorted((a, b) => b.createdAt.compareTo(a.createdAt)),
          );
      emit(DashboardTodoSuccess(data: data));
    } catch (_) {
      emit(const DashboardTodoFailure(message: 'Ops. Something happened!'));
    }
  }
}
