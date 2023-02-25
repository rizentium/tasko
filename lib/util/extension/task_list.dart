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
}
