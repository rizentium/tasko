part of 'create_task_cubit.dart';

abstract class CreateTaskState {
  const CreateTaskState();
}

class CreateTaskInitial extends CreateTaskState {}

class CreateTaskLoading extends CreateTaskState {}

class CreateTaskSuccess extends CreateTaskState {}

class CreateTaskFailure extends CreateTaskState {
  final String message;

  const CreateTaskFailure({required this.message});
}
