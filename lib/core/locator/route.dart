import 'package:go_router/go_router.dart';
import 'package:tasko/core/locator/registrar.dart';

abstract class Route implements Registrar {
  String get path {
    throw UnimplementedError();
  }

  GoRoute get route {
    throw UnimplementedError();
  }
}
