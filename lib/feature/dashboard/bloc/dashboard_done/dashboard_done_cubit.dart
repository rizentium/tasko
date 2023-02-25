import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/domain/usecases/tasks/stream_todo_task_usecase.dart';
import 'package:tasko/util/extension/task_list.dart';

part 'dashboard_done_state.dart';

class DashboardDoneCubit extends Cubit<DasboardDoneState> {
  final StreamTodoTaskUsecase _streamTodoTaskUsecase;

  DashboardDoneCubit({required StreamTodoTaskUsecase streamTodoTaskUsecase})
      : _streamTodoTaskUsecase = streamTodoTaskUsecase,
        super(DashboardDoneInitial());

  Future<void> initialize() async {
    emit(DashboardDoneLoading());

    try {
      final data = _streamTodoTaskUsecase
          .execute()
          .asyncMap<List<TaskEntity>>((event) => event.getDoneList());
      emit(DashboardDoneSuccess(data: data));
    } catch (_) {
      emit(
        const DashboardDoneFailure(message: 'Ops. Something happened!'),
      );
    }
  }
}
