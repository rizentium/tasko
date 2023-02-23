import 'package:json_annotation/json_annotation.dart';
import 'package:tasko/data/entities/task_tracker.dart';

part 'task.g.dart';

@JsonSerializable()
class TaskEntity {
  final String id;
  final String title;
  final String description;
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
}
