import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/feature/home/cubit/home_interface.dart';
import 'package:tasko/feature/home/screen/dashboard.dart';
import 'package:tasko/feature/home/screen/profile.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static final initialState = HomeChanged(
    currentIndex: 0,
    navigationItems: [
      HomeNavigationItem(
        icon: const Icon(Icons.home),
        label: 'Dashboard',
        screen: const DashboardScreen(),
      ),
      HomeNavigationItem(
        icon: const Icon(Icons.person),
        label: 'User Profile',
        screen: const ProfileScreen(),
      ),
    ],
  );

  HomeCubit() : super(initialState);

  onUpdateNavigationItem(int index) {
    emit(HomeChanged(
      currentIndex: index,
      navigationItems: state.navigationItems,
    ));
  }
}
