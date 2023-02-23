import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/core/design_system/ui/task_item.dart';
import 'package:tasko/domain/usecases/tasks/get_todo_task_usecase.dart';
import 'package:tasko/feature/dashboard/bloc/dashboard_todo/dashboard_todo_cubit.dart';

class DashboardTodoScreen extends StatelessWidget {
  final GetTodoTaskUsecase _getTodoTaskUsecase;

  const DashboardTodoScreen(
      {super.key, required GetTodoTaskUsecase getTodoTaskUsecase})
      : _getTodoTaskUsecase = getTodoTaskUsecase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardTodoCubit(
        getTodoTaskUsecase: _getTodoTaskUsecase,
      ),
      child: const _DashboardTodoScreen(),
    );
  }
}

class _DashboardTodoScreen extends StatefulWidget {
  const _DashboardTodoScreen();

  @override
  State<_DashboardTodoScreen> createState() => _DashboardTodoScreenState();
}

class _DashboardTodoScreenState extends State<_DashboardTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardTodoCubit, DashboardTodoState>(
      listener: (context, state) {},
      child: BlocBuilder<DashboardTodoCubit, DashboardTodoState>(
        builder: (context, state) {
          final data = state.data
              .map(
                (e) => TaskItem(
                  id: e.id,
                  title: e.title,
                  createdAt: e.createdAt,
                ),
              )
              .toList();

          return Scaffold(
            body: data.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    itemBuilder: (context, index) {
                      return data[index];
                    },
                    itemCount: data.length,
                  )
                : const Center(
                    child: Text('Ops. You don\'t have a task'),
                  ),
          );
        },
      ),
    );
  }
}
