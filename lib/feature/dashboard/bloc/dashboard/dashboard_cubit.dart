import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/domain/usecases/tasks/get_todo_task_usecase.dart';

import '../../screen/dashboard_done.dart';
import '../../screen/dashboard_in_progress.dart';
import '../../screen/dashboard_todo.dart';
import 'dashboard_interface.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetTodoTaskUsecase _getTodoTaskUsecase;

  DashboardState get initialState {
    return DashboardInitial();
  }

  DashboardCubit({required GetTodoTaskUsecase getTodoTaskUsecase})
      : _getTodoTaskUsecase = getTodoTaskUsecase,
        super(DashboardInitial());

  void initialize() {
    emit(DashboardLoading());
    try {
      emit(
        DashboardSuccess(
          tabItems: [
            DashboardTabItem(
              screen: DashboardTodoScreen(
                getTodoTaskUsecase: _getTodoTaskUsecase,
              ),
              tab: const Tab(
                text: 'To Do',
              ),
            ),
            DashboardTabItem(
              screen: const DashboardInProgressScreen(),
              tab: const Tab(
                text: 'In Progress',
              ),
            ),
            DashboardTabItem(
              screen: const DashboardDoneScreen(),
              tab: const Tab(
                text: 'Done',
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      emit(const DashboardFailure(message: 'Ops. Something happeded!'));
    }
  }
}
