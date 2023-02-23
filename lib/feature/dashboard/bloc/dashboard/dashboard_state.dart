part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {
  final List<DashboardTabItem> tabItems;

  const DashboardState({this.tabItems = const []});

  List<Tab> getTabs() => tabItems.map((e) => e.tab).toList();

  List<Widget> getScreens() => tabItems.map((e) => e.screen).toList();
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  const DashboardSuccess({required super.tabItems});
}

class DashboardFailure extends DashboardState {
  final String message;

  const DashboardFailure({required this.message});
}
