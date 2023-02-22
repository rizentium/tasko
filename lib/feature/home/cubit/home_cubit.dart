import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/domain/usecases/user/get_user_usacase.dart';
import 'package:tasko/feature/home/cubit/home_interface.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetUserUsecase _getUserUsecase;
  final Widget _profileScreen;
  final Widget _dashboardScreen;

  HomeCubit({
    required GetUserUsecase getUserUsecase,
    required Widget profileScreen,
    required Widget dashboardScreen,
  })  : _getUserUsecase = getUserUsecase,
        _profileScreen = profileScreen,
        _dashboardScreen = dashboardScreen,
        super(HomeInitial());

  List<HomeNavigationItem> get _items {
    return [
      HomeNavigationItem(
        icon: const Icon(Icons.home),
        label: 'Dashboard',
        screen: _dashboardScreen,
      ),
      HomeNavigationItem(
        icon: const Icon(Icons.person),
        label: 'User Profile',
        screen: _profileScreen,
      ),
    ];
  }

  Future<void> initialize() async {
    final user = _getUserUsecase.execute();

    if (user == null) {
      emit(HomeUnauthorized());
    } else {
      emit(HomeChanged(
        currentIndex: 0,
        navigationItems: _items,
      ));
    }
  }

  onUpdateNavigationItem(int index) {
    emit(HomeChanged(
      currentIndex: index,
      navigationItems: _items,
    ));
  }
}
