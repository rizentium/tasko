import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tasko/core/locator/usecase.dart';
import 'package:tasko/data/repositories/user/firebase.dart';

class GetUserUsecase implements Usecase<User?> {
  final FirebaseUserRepository _firebaseUserRepository;

  GetUserUsecase({required FirebaseUserRepository firebaseUserRepository})
      : _firebaseUserRepository = firebaseUserRepository;

  User? execute() => _firebaseUserRepository.getCurrentUser();

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => GetUserUsecase(
        firebaseUserRepository: locator(),
      ),
    );
  }
}
