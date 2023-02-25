import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/domain/usecases/tasks/stream_todo_task_usecase.dart';

part 'dashboard_in_progress_state.dart';

class DashboardInProgressCubit extends Cubit<DashboardInProgressState> {
  final StreamTodoTaskUsecase _streamTodoTaskUsecase;

  DashboardInProgressCubit(
      {required StreamTodoTaskUsecase streamTodoTaskUsecase})
      : _streamTodoTaskUsecase = streamTodoTaskUsecase,
        super(DashboardInProgressInitial());

  Future<void> initialize() async {
    emit(DashboardInProgressLoading());

    try {
      final data = _streamTodoTaskUsecase.execute().asyncMap<List<TaskEntity>>(
            (event) => event
                .where((e) => e.startedAt != null && e.finishedAt == null)
                .sorted((a, b) => b.createdAt.compareTo(a.createdAt)),
          );
      emit(DashboardInProgressSuccess(data: data));
    } catch (_) {
      emit(
        const DashboardInProgressFailure(message: 'Ops. Something happened!'),
      );
    }
  }
}
