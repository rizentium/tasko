part of 'dashboard_todo_cubit.dart';

@immutable
abstract class DashboardTodoState {
  final List<TaskEntity> data;

  const DashboardTodoState({this.data = const []});
}

class DashboardTodoInitial extends DashboardTodoState {}

class DashboardTodoLoading extends DashboardTodoState {}

class DashboardTodoSuccess extends DashboardTodoState {
  const DashboardTodoSuccess({required super.data});
}

class DashboardTodoFailure extends DashboardTodoState {
  final String message;

  const DashboardTodoFailure({required this.message});
}
