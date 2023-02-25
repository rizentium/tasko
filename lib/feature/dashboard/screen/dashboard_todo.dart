import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/domain/usecases/tasks/stream_todo_task_usecase.dart';
import 'package:tasko/feature/dashboard/bloc/dashboard_todo/dashboard_todo_cubit.dart';
import 'package:tasko/feature/dashboard/widget/dashboard_stream_builder.dart';

class DashboardTodoScreen extends StatelessWidget {
  final StreamTodoTaskUsecase _streamTodoTaskUsecase;
  final String taskDetailUrl;

  const DashboardTodoScreen({
    super.key,
    required StreamTodoTaskUsecase streamTodoTaskUsecase,
    required this.taskDetailUrl,
  }) : _streamTodoTaskUsecase = streamTodoTaskUsecase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardTodoCubit(
        streamTodoTaskUsecase: _streamTodoTaskUsecase,
      )..initialize(),
      child: _DashboardTodoScreen(taskDetailUrl: taskDetailUrl),
    );
  }
}

class _DashboardTodoScreen extends StatelessWidget {
  final String taskDetailUrl;

  const _DashboardTodoScreen({required this.taskDetailUrl});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardTodoCubit, DashboardTodoState>(
      builder: (context, state) {
        return Scaffold(
          body: DashboardStreamBuilder(
            stream: state.data,
            onTap: (context, data) => context.push(taskDetailUrl, extra: data),
            messageEmpty: 'Create your first task',
            messageNoConnection: 'Please check your connection',
          ),
        );
      },
    );
  }
}
