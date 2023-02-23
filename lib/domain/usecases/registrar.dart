import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/registrar.dart';
import 'package:tasko/domain/usecases/tasks/get_todo_task_usecase.dart';
import 'package:tasko/domain/usecases/user/get_user_usacase.dart';
import 'package:tasko/domain/usecases/user/signin_user_usecase.dart';
import 'package:tasko/domain/usecases/user/signout_user_usecase.dart';

class UsecaseRegistrar implements Registrar {
  @override
  Future<void> register(GetIt locator) async {
    final registrars = [
      // User Usecases
      GetUserUsecase(firebaseUserRepository: locator()),
      SignInUserUsecase(firebaseUserRepository: locator()),
      SignOutUserUsecase(firebaseUserRepository: locator()),

      // Task Usecases
      GetTodoTaskUsecase(taskRepository: locator()),
    ];

    await Future.wait(registrars.map((e) => e.register(locator)));
  }
}
