part of 'dashboard_done_cubit.dart';

@immutable
abstract class DasboardDoneState {
  final Stream<List<TaskEntity>>? data;

  const DasboardDoneState({this.data});
}

class DashboardDoneInitial extends DasboardDoneState {}

class DashboardDoneLoading extends DasboardDoneState {}

class DashboardDoneSuccess extends DasboardDoneState {
  const DashboardDoneSuccess({required super.data});
}

class DashboardDoneFailure extends DasboardDoneState {
  final String message;

  const DashboardDoneFailure({required this.message});
}
