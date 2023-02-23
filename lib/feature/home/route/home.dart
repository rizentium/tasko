import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/locator/route.dart';
import 'package:tasko/domain/usecases/user/get_user_usacase.dart';
import 'package:tasko/feature/home/screen/home.dart';

class HomeRoute implements RouteRegistrar {
  final GetUserUsecase _getUserUsecase;
  final Widget _profileScreen;
  final Widget _dashboardScreen;
  final String onUnauthorizedUrl;

  HomeRoute({
    required this.onUnauthorizedUrl,
    required GetUserUsecase getUserUsecase,
    required Widget profileScreen,
    required Widget dashboardScreen,
  })  : _getUserUsecase = getUserUsecase,
        _profileScreen = profileScreen,
        _dashboardScreen = dashboardScreen;

  static String path = '/home';

  @override
  GoRoute get route {
    return GoRoute(
      path: path,
      builder: (context, state) => HomeScreen(
        onUnauthorizedUrl: onUnauthorizedUrl,
        getUserUsecase: _getUserUsecase,
        profileScreen: _profileScreen,
        dashboardScreen: _dashboardScreen,
      ),
    );
  }

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => HomeRoute(
        onUnauthorizedUrl: onUnauthorizedUrl,
        getUserUsecase: locator(),
        profileScreen: _profileScreen,
        dashboardScreen: _dashboardScreen,
      ),
    );
  }
}
