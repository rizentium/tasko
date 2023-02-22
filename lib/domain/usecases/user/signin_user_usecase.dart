import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/usecase.dart';
import 'package:tasko/data/repositories/user/firebase.dart';

class SignInUserUsecase implements Usecase<Future<UserCredential>> {
  final FirebaseUserRepository _firebaseUserRepository;

  SignInUserUsecase({required FirebaseUserRepository firebaseUserRepository})
      : _firebaseUserRepository = firebaseUserRepository;

  @override
  execute() => _firebaseUserRepository.signInWithGoogle();

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => SignInUserUsecase(firebaseUserRepository: locator()),
    );
  }
}
