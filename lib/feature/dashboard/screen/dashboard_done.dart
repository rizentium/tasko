import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/domain/usecases/tasks/stream_todo_task_usecase.dart';
import 'package:tasko/feature/dashboard/bloc/dashboard_done/dashboard_done_cubit.dart';
import 'package:tasko/feature/dashboard/widget/dashboard_stream_builder.dart';

class DashboardDoneScreen extends StatelessWidget {
  final StreamTodoTaskUsecase _streamTodoTaskUsecase;
  final String taskDetailUrl;

  const DashboardDoneScreen({
    super.key,
    required StreamTodoTaskUsecase streamTodoTaskUsecase,
    required this.taskDetailUrl,
  }) : _streamTodoTaskUsecase = streamTodoTaskUsecase;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardDoneCubit(
        streamTodoTaskUsecase: _streamTodoTaskUsecase,
      )..initialize(),
      child: _DashboardDoneScreen(taskDetailUrl: taskDetailUrl),
    );
  }
}

class _DashboardDoneScreen extends StatelessWidget {
  final String taskDetailUrl;

  const _DashboardDoneScreen({required this.taskDetailUrl});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardDoneCubit, DasboardDoneState>(
      builder: (context, state) {
        return Scaffold(
          body: DashboardStreamBuilder(
            stream: state.data,
            onTap: (context, data) => context.push(taskDetailUrl, extra: data),
            messageEmpty: 'You have no finished task',
            messageNoConnection: 'Please check your connection',
          ),
        );
      },
    );
  }
}
