part of 'dashboard_in_progress_cubit.dart';

@immutable
abstract class DashboardInProgressState {
  final Stream<List<TaskEntity>>? data;

  const DashboardInProgressState({this.data});
}

class DashboardInProgressInitial extends DashboardInProgressState {}

class DashboardInProgressLoading extends DashboardInProgressState {}

class DashboardInProgressSuccess extends DashboardInProgressState {
  const DashboardInProgressSuccess({required super.data});
}

class DashboardInProgressFailure extends DashboardInProgressState {
  final String message;

  const DashboardInProgressFailure({required this.message});
}
