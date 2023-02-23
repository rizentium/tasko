import 'package:json_annotation/json_annotation.dart';

part 'task_tracker.g.dart';

@JsonSerializable()
class TaskTracker {
  final DateTime startedAt;
  final DateTime finishedAt;

  TaskTracker({required this.startedAt, required this.finishedAt});

  factory TaskTracker.fromJson(Map<String, dynamic> json) =>
      _$TaskTrackerFromJson(json);

  Map<String, dynamic> toJson() => _$TaskTrackerToJson(this);
}
