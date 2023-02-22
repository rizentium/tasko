import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/usecase.dart';
import 'package:tasko/data/repositories/user/firebase.dart';

class SignOutUserUsecase implements Usecase<Future<void>> {
  final FirebaseUserRepository _firebaseUserRepository;

  SignOutUserUsecase({required FirebaseUserRepository firebaseUserRepository})
      : _firebaseUserRepository = firebaseUserRepository;

  @override
  execute() => _firebaseUserRepository.signOut();

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => SignOutUserUsecase(firebaseUserRepository: locator()),
    );
  }
}
