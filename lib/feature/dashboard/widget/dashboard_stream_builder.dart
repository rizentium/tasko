import 'package:flutter/material.dart';
import 'package:tasko/core/design_system/ui/task_item.dart';
import 'package:tasko/data/entities/task.dart';

class DashboardStreamBuilder extends StreamBuilderBase<List<TaskEntity>,
    AsyncSnapshot<List<TaskEntity>>> {
  final List<TaskEntity>? initialData;
  final void Function(BuildContext context, TaskEntity data)? onTap;
  final String messageEmpty;
  final String messageNoConnection;

  const DashboardStreamBuilder({
    super.key,
    Stream<List<TaskEntity>>? stream,
    this.initialData,
    this.onTap,
    required this.messageEmpty,
    required this.messageNoConnection,
  }) : super(stream: stream);

  Widget localBuilder(
    BuildContext context,
    AsyncSnapshot<List<TaskEntity>> currentSummary,
  ) {
    if (currentSummary.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (currentSummary.connectionState == ConnectionState.none) {
      return Center(child: Text(messageNoConnection));
    }

    final data = currentSummary.data;
    if (data != null && data.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        itemBuilder: (context, index) {
          final item = data.elementAt(index);
          return TaskItem(
            id: item.id,
            title: item.title,
            createdAt: item.createdAt,
            onTap: () => onTap?.call(context, item),
          );
        },
        itemCount: data.length,
      );
    }

    return Center(child: Text(messageEmpty));
  }

  @override
  Widget build(BuildContext context, currentSummary) =>
      localBuilder(context, currentSummary);

  @override
  initial() => initialData == null
      ? const AsyncSnapshot<List<TaskEntity>>.nothing()
      : AsyncSnapshot<List<TaskEntity>>.withData(
          ConnectionState.none, initialData as List<TaskEntity>);

  @override
  afterData(current, data) {
    return AsyncSnapshot<List<TaskEntity>>.withData(
        ConnectionState.active, data);
  }
}
