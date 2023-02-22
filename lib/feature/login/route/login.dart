import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/locator/route.dart';
import 'package:tasko/domain/usecases/user/signin_user_usecase.dart';
import 'package:tasko/feature/login/screen/login_screen.dart';

class LoginRoute implements RouteRegistrar {
  final SignInUserUsecase _signInUserUsecase;
  final void Function(BuildContext context) onSuccess;

  LoginRoute({
    required SignInUserUsecase signInUserUsecase,
    required this.onSuccess,
  }) : _signInUserUsecase = signInUserUsecase;

  static String path = '/login';

  @override
  GoRoute get route {
    return GoRoute(
      path: path,
      builder: (context, state) => LoginScreen(
        signInUserUsecase: _signInUserUsecase,
        onSuccess: onSuccess,
      ),
    );
  }

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => LoginRoute(signInUserUsecase: locator(), onSuccess: onSuccess),
    );
  }
}
