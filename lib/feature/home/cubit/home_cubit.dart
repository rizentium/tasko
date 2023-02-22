import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/domain/usecases/user/get_user_usacase.dart';
import 'package:tasko/feature/home/cubit/home_interface.dart';
import 'package:tasko/feature/home/screen/dashboard.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetUserUsecase _getUserUsecase;
  final Widget _profileScreen;

  HomeCubit({
    required GetUserUsecase getUserUsecase,
    required Widget profileScreen,
  })  : _getUserUsecase = getUserUsecase,
        _profileScreen = profileScreen,
        super(HomeInitial());

  List<HomeNavigationItem> get _items {
    return [
      HomeNavigationItem(
        icon: const Icon(Icons.home),
        label: 'Dashboard',
        screen: const DashboardScreen(),
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
