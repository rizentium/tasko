part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  final int currentIndex;
  final List<HomeNavigationItem> navigationItems;

  const HomeState({
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

class HomeChanged extends HomeState {
  const HomeChanged({
    required super.currentIndex,
    required super.navigationItems,
  });
}
