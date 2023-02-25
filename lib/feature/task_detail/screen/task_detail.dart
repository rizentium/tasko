import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/design_system/ui/appbar_close.dart';
import 'package:tasko/core/extension/context.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/domain/usecases/tasks/update_todo_task_usecase.dart';
import 'package:tasko/feature/task_detail/cubit/task_detail_cubit.dart';
import 'package:tasko/feature/task_detail/widget/bottom_action_button.dart';
import 'package:tasko/feature/task_detail/widget/history_detail.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskEntity? task;
  final String taskUpdateUrl;
  final String onSuccessUpdateUrl;
  final UpdateTodoTaskUsecase _updateTodoTaskUsecase;

  const TaskDetailScreen({
    super.key,
    this.task,
    required this.taskUpdateUrl,
    required this.onSuccessUpdateUrl,
    required UpdateTodoTaskUsecase updateTodoTaskUsecase,
  }) : _updateTodoTaskUsecase = updateTodoTaskUsecase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskDetailCubit(
        updateTodoTaskUsecase: _updateTodoTaskUsecase,
      )..initialize(task),
      child: _TaskDetailScreen(
        taskUpdateUrl: taskUpdateUrl,
        onSuccessUpdateUrl: onSuccessUpdateUrl,
        task: task,
      ),
    );
  }
}

class _TaskDetailScreen extends StatelessWidget {
  final TaskEntity? task;
  final String taskUpdateUrl;
  final String onSuccessUpdateUrl;

  const _TaskDetailScreen({
    this.task,
    required this.taskUpdateUrl,
    required this.onSuccessUpdateUrl,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskDetailCubit, TaskDetailState>(
      listener: (context, state) {
        if (state is TaskDetailFailure) {
          context.showSnackBar(message: state.message);
        }

        if (state is TaskDetailSuccess) {
          context.go(onSuccessUpdateUrl);
        }

        if (state is TaskDetailTracking) {
          context.showSnackBar(message: state.message);
        }
      },
      child: BlocBuilder<TaskDetailCubit, TaskDetailState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBarClose(
              context: context,
              title: const Text('Task Detail'),
              actions: [
                IconButton(
                  onPressed: () => context.push(taskUpdateUrl, extra: task),
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            bottomNavigationBar: BottomActionButton(
              hasStarted: task?.startedAt != null,
              hasFinished: task?.finishedAt != null,
              trackers: task?.trackers,
              onPressed: (hasStarted, hasFinished) {
                final cubit = context.read<TaskDetailCubit>();
                if (hasFinished) {
                  cubit.setTaskToInProgress(task);
                  return;
                }
                if (hasStarted) {
                  cubit.finishTask(task);
                  return;
                }

                cubit.startTask(task);
              },
              onTracking: (type) => context
                  .read<TaskDetailCubit>()
                  .onTracking(task: task, type: type),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    task?.title ?? 'Title is not defined',
                    style: context.textTheme.titleLarge,
                  ),
                  const Divider(),
                  Text(
                    task?.description ?? 'Description is not defined',
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  if (task?.durationTracking != null)
                    Text('Spent Duration: ${task?.durationTracking}'),
                  if (task?.durationCompleted != null)
                    Text('Completed in ${task?.durationCompleted}'),
                  const Divider(),
                  HistoryDetail(
                    createdAt: task?.createdAt,
                    startedAt: task?.startedAt,
                    finishedAt: task?.finishedAt,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
