import 'package:go_router/go_router.dart';
import 'package:tasko/feature/home/screen/home.dart';

class HomeRoute {
  static String path = '/home';

  static GoRoute get route {
    return GoRoute(
      path: path,
      builder: (context, state) => const HomeScreen(),
    );
  }
}
