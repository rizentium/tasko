part of 'task_detail_cubit.dart';

@immutable
abstract class TaskDetailState {}

class TaskDetailInitial extends TaskDetailState {}

class TaskDetailLoading extends TaskDetailState {}

class TaskDetailSuccess extends TaskDetailState {}

class TaskDetailFailure extends TaskDetailState {
  final String message;

  TaskDetailFailure({required this.message});
}
