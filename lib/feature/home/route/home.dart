import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/locator/route.dart';
import 'package:tasko/domain/usecases/user/get_user_usacase.dart';
import 'package:tasko/feature/home/screen/home.dart';
import 'package:tasko/feature/login/route/login.dart';

class HomeRoute implements Route {
  final GetUserUsecase _getUserUsecase;
  final LoginRoute _loginRoute;

  HomeRoute({
    required GetUserUsecase getUserUsecase,
    required LoginRoute loginRoute,
  })  : _getUserUsecase = getUserUsecase,
        _loginRoute = loginRoute;

  @override
  String path = '/home';

  @override
  GoRoute get route {
    return GoRoute(
      path: path,
      builder: (context, state) => const HomeScreen(),
      redirect: (context, state) async {
        if (_getUserUsecase.execute() == null) {
          return _loginRoute.path;
        }
      },
    );
  }

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => HomeRoute(getUserUsecase: locator(), loginRoute: locator()),
    );
  }
}
