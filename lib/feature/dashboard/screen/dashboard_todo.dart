import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/design_system/ui/task_item.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/domain/usecases/tasks/stream_todo_task_usecase.dart';
import 'package:tasko/feature/dashboard/bloc/dashboard_todo/dashboard_todo_cubit.dart';

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

class _DashboardTodoScreen extends StatefulWidget {
  final String taskDetailUrl;

  const _DashboardTodoScreen({required this.taskDetailUrl});

  @override
  State<_DashboardTodoScreen> createState() => _DashboardTodoScreenState();
}

class _DashboardTodoScreenState extends State<_DashboardTodoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardTodoCubit, DashboardTodoState>(
      builder: (context, state) {
        return Scaffold(
          body: StreamBuilder<List<TaskEntity>>(
            stream: state.data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.connectionState == ConnectionState.none) {
                return const Center(
                  child: Text('Please check your connection'),
                );
              }

              // filter only for task that not started yet.
              final data = snapshot.data
                  ?.where((e) => e.startedAt == null)
                  .sorted((a, b) => b.createdAt.compareTo(a.createdAt));

              if (data != null && data.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  itemBuilder: (context, index) {
                    final item = data.elementAt(index);
                    return TaskItem(
                      id: item.id,
                      title: item.title,
                      createdAt: item.createdAt,
                      onTap: () => _onTap(item),
                    );
                  },
                  itemCount: data.length,
                );
              }

              return const Center(child: Text('Create your first task'));
            },
          ),
        );
      },
    );
  }

  _onTap(TaskEntity data) {
    context.push(widget.taskDetailUrl, extra: data);
  }
}
