import 'package:collection/collection.dart';
import 'package:tasko/data/entities/task.dart';

extension ListOfTaskExtended on List<TaskEntity> {
  List<TaskEntity> getToDoList() {
    return where((e) => e.startedAt == null)
        .sorted((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  List<TaskEntity> getInProgressList() {
    return where((e) => e.startedAt != null && e.finishedAt == null).sorted(
      (a, b) => a.startedAt?.compareTo(b.startedAt ?? DateTime.now()) ?? 0,
    );
  }

  List<TaskEntity> getDoneList() {
    return where((e) => e.finishedAt != null).sorted(
      (a, b) => b.finishedAt?.compareTo(a.finishedAt ?? DateTime.now()) ?? 0,
    );
  }

  String toCSV() {
    final headers = [
      'ID',
      'Title',
      'Description',
      'Created at',
      'Started at',
      'Finished at',
      'Backlog Time',
      'In Progress Time',
      'Total Time',
      'Working Time',
    ].map((e) => '"$e"').join(', ');
    final items = map(
      (e) => [
        e.id,
        e.title,
        e.description,
        e.createdAt,
        e.startedAt,
        e.finishedAt,
        e.durationBlocked,
        e.durationInProgress,
        e.durationInProgress,
        e.durationWorking,
      ].map((e) => '"$e"').join(', '),
    ).toList();

    return [headers, ...items].join('\n');
  }
}
