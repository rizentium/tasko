import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasko/domain/usecases/user/get_user_usacase.dart';
import 'package:tasko/domain/usecases/user/signout_user_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserUsecase _getUserUsecase;
  final SignOutUserUsecase _signOutUserUsecase;
  ProfileCubit(
      {required GetUserUsecase getUserUsecase,
      required SignOutUserUsecase signOutUserUsecase})
      : _getUserUsecase = getUserUsecase,
        _signOutUserUsecase = signOutUserUsecase,
        super(const ProfileInitial());

  void initialize() {
    final user = _getUserUsecase.execute();
    emit(ProfileSuccess(data: user));
  }

  Future<void> signOut() async {
    try {
      await _signOutUserUsecase.execute();
      emit(ProfileSignedOut());
    } catch (e) {
      emit(ProfileFailure(message: 'Ops. Something when wrong!'));
    }
  }
}
