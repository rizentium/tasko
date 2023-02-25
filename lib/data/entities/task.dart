import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:tasko/data/entities/task_tracker.dart';

part 'task.g.dart';

@JsonSerializable()
class TaskEntity {
  final String id;
  final String title;
  final String description;

  @JsonKey(toJson: _trackersToJson)
  final List<TaskTracker>? trackers;

  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? finishedAt;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    this.trackers,
    required this.createdAt,
    this.startedAt,
    this.finishedAt,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TaskEntityToJson(this);

  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    List<TaskTracker>? trackers,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? finishedAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      trackers: trackers ?? this.trackers,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
    );
  }

  static List<Map<String, dynamic>>? _trackersToJson(List<TaskTracker>? value) {
    return value?.map((e) => e.toJson()).toList();
  }

  String? get spendingTime {
    List<List<DateTime?>>? pointMap = [];

    for (int x = 0; x < (trackers?.length ?? 0); x++) {
      if (x % 2 == 1) {
        final points = [
          trackers?.elementAt(x - 1),
          trackers?.elementAt(x),
        ].map((e) => e?.point).toList();

        pointMap.add(points);
      }
    }

    int durationInSeconds = 0;
    for (final e in pointMap) {
      final startedAt = e[0];
      final endedAt = e[1];

      if (startedAt != null && endedAt != null) {
        final duration = endedAt.difference(startedAt);
        durationInSeconds += duration.inSeconds;
      }
    }

    if (durationInSeconds == 0) {
      return null;
    }

    final result = Duration(seconds: durationInSeconds).toString();
    return result.split('.').first;
  }
}
