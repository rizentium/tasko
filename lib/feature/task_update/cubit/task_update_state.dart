part of 'task_update_cubit.dart';

@immutable
abstract class TaskUpdateState {
  const TaskUpdateState();
}

class TaskUpdateInitial extends TaskUpdateState {}

class TaskUpdateLoading extends TaskUpdateState {}

class TaskUpdateSuccess extends TaskUpdateState {}

class TaskUpdateFailure extends TaskUpdateState {
  final String message;

  const TaskUpdateFailure({required this.message});
}
