import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/design_system/ui/appbar_close.dart';
import 'package:tasko/core/extension/context.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/feature/task_detail/widget/history_detail.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskEntity? task;
  final String taskUpdateUrl;

  const TaskDetailScreen({super.key, this.task, required this.taskUpdateUrl});

  @override
  Widget build(BuildContext context) {
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
            const Divider(),
            HistoryDetail(
              createdAt: task?.createdAt,
            ),
          ],
        ),
      ),
    );
  }
}
