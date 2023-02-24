import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/core/design_system/ui/task_item.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/domain/usecases/tasks/stream_todo_task_usecase.dart';
import 'package:tasko/feature/dashboard/bloc/dashboard_todo/dashboard_todo_cubit.dart';

class DashboardTodoScreen extends StatelessWidget {
  final StreamTodoTaskUsecase _streamTodoTaskUsecase;

  const DashboardTodoScreen(
      {super.key, required StreamTodoTaskUsecase streamTodoTaskUsecase})
      : _streamTodoTaskUsecase = streamTodoTaskUsecase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardTodoCubit(
        streamTodoTaskUsecase: _streamTodoTaskUsecase,
      )..initialize(),
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
              final data = snapshot.data?.where((e) => e.startedAt == null);

              if (data != null && data.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  itemBuilder: (context, index) {
                    final item = data.elementAt(index);
                    return TaskItem(
                      id: item.id,
                      title: item.title,
                      createdAt: item.createdAt,
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
}
