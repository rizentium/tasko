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
  final void Function(BuildContext context) onUnauthorized;

  HomeRoute({
    required this.onUnauthorized,
    required GetUserUsecase getUserUsecase,
    required Widget profileScreen,
  })  : _getUserUsecase = getUserUsecase,
        _profileScreen = profileScreen;

  static String path = '/home';

  @override
  GoRoute get route {
    return GoRoute(
      path: path,
      builder: (context, state) => HomeScreen(
        onUnauthorized: onUnauthorized,
        getUserUsecase: _getUserUsecase,
        profileScreen: _profileScreen,
      ),
    );
  }

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => HomeRoute(
        onUnauthorized: onUnauthorized,
        getUserUsecase: locator(),
        profileScreen: _profileScreen,
      ),
    );
  }
}
