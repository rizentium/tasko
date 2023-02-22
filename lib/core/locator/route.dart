import 'package:go_router/go_router.dart';
import 'package:tasko/core/locator/registrar.dart';

abstract class RouteRegistrar implements Registrar {
  GoRoute get route {
    throw UnimplementedError();
  }
}
