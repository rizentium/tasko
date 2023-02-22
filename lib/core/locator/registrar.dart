import 'package:get_it/get_it.dart';

abstract class Registrar {
  Future<void> register(GetIt locator) async {
    throw UnimplementedError();
  }
}
