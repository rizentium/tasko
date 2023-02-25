import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/domain/usecases/tasks/stream_todo_task_usecase.dart';
import 'package:tasko/util/extension/task_list.dart';

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
      final data = _streamTodoTaskUsecase
          .execute()
          .asyncMap<List<TaskEntity>>((event) => event.getInProgressList());
      emit(DashboardInProgressSuccess(data: data));
    } catch (_) {
      emit(
        const DashboardInProgressFailure(message: 'Ops. Something happened!'),
      );
    }
  }
}
