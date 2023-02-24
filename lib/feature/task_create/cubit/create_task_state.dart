part of 'create_task_cubit.dart';

abstract class TaskCreateState {
  const TaskCreateState();
}

class TaskCreateInitial extends TaskCreateState {}

class TaskCreateLoading extends TaskCreateState {}

class TaskCreateSuccess extends TaskCreateState {}

class TaskCreateFailure extends TaskCreateState {
  final String message;

  const TaskCreateFailure({required this.message});
}
