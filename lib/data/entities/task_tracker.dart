import 'package:json_annotation/json_annotation.dart';

part 'task_tracker.g.dart';

enum TaskTrackerType {
  @JsonValue('started')
  started,
  @JsonValue('stopped')
  stopped
}

@JsonSerializable()
class TaskTracker {
  final DateTime point;
  final TaskTrackerType type;

  TaskTracker({required this.point, required this.type});

  factory TaskTracker.fromJson(Map<String, dynamic> json) =>
      _$TaskTrackerFromJson(json);

  Map<String, dynamic> toJson() => _$TaskTrackerToJson(this);
}
