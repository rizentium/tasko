import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/registrar.dart';
import 'package:tasko/domain/usecases/user/get_user_usacase.dart';

class UsecaseRegistrar implements Registrar {
  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(() => GetUserUsecase());
  }
}
