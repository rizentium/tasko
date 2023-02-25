part of 'task_detail_cubit.dart';

@immutable
abstract class TaskDetailState {
  final TaskEntity? data;

  const TaskDetailState({this.data});
}

class TaskDetailInitial extends TaskDetailState {}

class TaskDetailLoading extends TaskDetailState {
  const TaskDetailLoading({super.data});
}

class TaskDetailSuccess extends TaskDetailState {
  const TaskDetailSuccess({super.data});
}

class TaskDetailFailure extends TaskDetailState {
  final String message;

  const TaskDetailFailure({super.data, required this.message});
}

class TaskDetailTracking extends TaskDetailState {
  final String message;

  const TaskDetailTracking({super.data, required this.message});
}
