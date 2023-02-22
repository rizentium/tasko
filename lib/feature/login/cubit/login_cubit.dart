import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasko/domain/usecases/user/signin_user_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SignInUserUsecase _signInUserUsecase;

  LoginCubit({required SignInUserUsecase signInUserUsecase})
      : _signInUserUsecase = signInUserUsecase,
        super(LoginInitial());

  Future<void> signInWithGoogle() async {
    try {
      final credential = await _signInUserUsecase.execute();

      if (credential.user != null) {
        emit(LoginSuccess());
      } else {
        throw Error();
      }
    } catch (e) {
      emit(LoginFailure(message: 'Failed, please check your connection'));
    }
  }
}
