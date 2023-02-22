import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/usecase.dart';

class GetUserUsecase implements Usecase<String?> {
  @override
  execute() {
    return null;
  }

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(() => GetUserUsecase());
  }
}
