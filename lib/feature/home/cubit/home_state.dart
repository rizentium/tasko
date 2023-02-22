part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeUnauthorized extends HomeState {}

class HomeChanged extends HomeState {
  final int currentIndex;
  final List<HomeNavigationItem> navigationItems;

  const HomeChanged({
    required this.currentIndex,
    required this.navigationItems,
  });

  List<BottomNavigationBarItem> get navigationItemList => navigationItems
      .map(
        (e) => BottomNavigationBarItem(
          icon: e.icon,
          label: e.label,
        ),
      )
      .toList();
}
