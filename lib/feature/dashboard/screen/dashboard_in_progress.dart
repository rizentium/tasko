import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/domain/usecases/tasks/stream_todo_task_usecase.dart';
import 'package:tasko/feature/dashboard/bloc/dashboard_in_progress/dashboard_in_progress_cubit.dart';

import '../widget/dashboard_stream_builder.dart';

class DashboardInProgressScreen extends StatelessWidget {
  final StreamTodoTaskUsecase _streamTodoTaskUsecase;
  final String taskDetailUrl;

  const DashboardInProgressScreen({
    super.key,
    required StreamTodoTaskUsecase streamTodoTaskUsecase,
    required this.taskDetailUrl,
  }) : _streamTodoTaskUsecase = streamTodoTaskUsecase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardInProgressCubit(
        streamTodoTaskUsecase: _streamTodoTaskUsecase,
      )..initialize(),
      child: _DashboardInProgressScreen(taskDetailUrl: taskDetailUrl),
    );
  }
}

class _DashboardInProgressScreen extends StatelessWidget {
  final String taskDetailUrl;

  const _DashboardInProgressScreen({required this.taskDetailUrl});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardInProgressCubit, DashboardInProgressState>(
      builder: (context, state) {
        return Scaffold(
          body: DashboardStreamBuilder(
            stream: state.data,
            onTap: (context, data) => context.push(taskDetailUrl, extra: data),
            messageEmpty: 'You have no in progress task',
            messageNoConnection: 'Please check your connection',
          ),
        );
      },
    );
  }
}
