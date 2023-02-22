import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasko/domain/usecases/user/signout_user_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SignOutUserUsecase _signOutUserUsecase;
  ProfileCubit({required SignOutUserUsecase signOutUserUsecase})
      : _signOutUserUsecase = signOutUserUsecase,
        super(ProfileInitial());

  Future<void> signOut() async {
    try {
      await _signOutUserUsecase.execute();
      emit(ProfileSignedOut());
    } catch (e) {
      emit(ProfileFailure(message: 'Ops. Something when wrong!'));
    }
  }
}
