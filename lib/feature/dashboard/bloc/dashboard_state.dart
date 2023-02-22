part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {
  final List<DashboardTabItem> tabItems;

  const DashboardState({required this.tabItems});

  List<Tab> getTabs() => tabItems.map((e) => e.tab).toList();

  List<Widget> getScreens() => tabItems.map((e) => e.screen).toList();
}

class DashboardInitial extends DashboardState {
  const DashboardInitial({required super.tabItems});
}
