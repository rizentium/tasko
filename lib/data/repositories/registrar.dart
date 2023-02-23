import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/registrar.dart';
import 'package:tasko/data/repositories/task/task.dart';
import 'package:tasko/data/repositories/user/firebase.dart';

class RepositoryRegistrar implements Registrar {
  final String? fakeIdToken;

  RepositoryRegistrar({this.fakeIdToken});

  @override
  Future<void> register(GetIt locator) async {
    final registrars = [
      FirebaseUserRepository(firebaseAuth: locator(), fakeIdToken: fakeIdToken),
      TaskRepository(firebaseDatabase: locator(), firebaseAuth: locator()),
    ];

    await Future.wait(registrars.map((e) => e.register(locator)));
  }
}
