import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/locator/route.dart';
import 'package:tasko/feature/login/screen/login_screen.dart';

class LoginRoute implements Route {
  @override
  String path = '/login';

  @override
  GoRoute get route {
    return GoRoute(
      path: path,
      builder: (context, state) => const LoginScreen(),
    );
  }

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(() => LoginRoute());
  }
}
