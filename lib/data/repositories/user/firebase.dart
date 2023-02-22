import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tasko/core/locator/repository.dart';

class FirebaseUserRepository implements Repository {
  final FirebaseAuth _firebaseAuth;
  final String? fakeIdToken;

  FirebaseUserRepository({
    required FirebaseAuth firebaseAuth,
    this.fakeIdToken,
  }) : _firebaseAuth = firebaseAuth;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: fakeIdToken ?? googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future<void> register(GetIt locator) async {
    locator.registerSingleton<FirebaseUserRepository>(FirebaseUserRepository(
      firebaseAuth: locator(),
      fakeIdToken: fakeIdToken,
    ));
  }
}
