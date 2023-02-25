import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:open_file/open_file.dart';
import 'package:tasko/domain/usecases/tasks/export_todo_task_usecase.dart';
import 'package:tasko/domain/usecases/user/get_user_usacase.dart';
import 'package:tasko/domain/usecases/user/signout_user_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserUsecase _getUserUsecase;
  final ExportTodoTaskUsecase _exportTodoTaskUsecase;
  final SignOutUserUsecase _signOutUserUsecase;
  ProfileCubit({
    required GetUserUsecase getUserUsecase,
    required ExportTodoTaskUsecase exportTodoTaskUsecase,
    required SignOutUserUsecase signOutUserUsecase,
  })  : _getUserUsecase = getUserUsecase,
        _signOutUserUsecase = signOutUserUsecase,
        _exportTodoTaskUsecase = exportTodoTaskUsecase,
        super(const ProfileInitial());

  void initialize() {
    final user = _getUserUsecase.execute();
    emit(ProfileSuccess(data: user));
  }

  Future<void> export() async {
    try {
      final path = await _exportTodoTaskUsecase.execute();

      if (path == null) {
        emit(ProfileFailure(
          data: state.data,
          message: 'Failed to export as CSV File',
        ));
        return;
      }

      final open = await OpenFile.open(path);

      if (open.type == ResultType.noAppToOpen) {
        await OpenFile.open(path, type: "text/plain");
      }
      emit(ProfileFileExported(data: state.data));
    } catch (e) {
      emit(ProfileFailure(data: state.data, message: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await _signOutUserUsecase.execute();
      emit(ProfileSignedOut());
    } catch (e) {
      emit(const ProfileFailure(message: 'Ops. Something when wrong!'));
    }
  }
}
