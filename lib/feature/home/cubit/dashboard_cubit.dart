import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/feature/home/cubit/dashboard_interface.dart';
import 'package:tasko/feature/home/screen/dashboard_done.dart';
import 'package:tasko/feature/home/screen/dashboard_in_progress.dart';
import 'package:tasko/feature/home/screen/dashboard_todo.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  static final initialState = DashboardInitial(
    tabItems: [
      DashboardTabItem(
        screen: const DashboardTodoScreen(),
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
  );

  DashboardCubit() : super(initialState);
}
