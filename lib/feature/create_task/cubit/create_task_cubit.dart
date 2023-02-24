import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/domain/usecases/tasks/create_todo_task_usecase.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  final CreateTodoTaskUsecase _createTodoTaskUsecase;

  CreateTaskCubit({required CreateTodoTaskUsecase createTodoTaskUsecase})
      : _createTodoTaskUsecase = createTodoTaskUsecase,
        super(CreateTaskInitial());

  Future<void> create({
    required String title,
    required String description,
  }) async {
    emit(CreateTaskLoading());

    final isValid = [title, description]
        .map((e) => e != '')
        .fold(true, (prev, curr) => prev && curr);

    if (!isValid) {
      emit(const CreateTaskFailure(
        message: 'Please fill all required text fields.',
      ));
      return;
    }

    try {
      final id = const Uuid(options: {'grng': UuidUtil.cryptoRNG}).v4();
      final taskEntity = TaskEntity(
        id: id,
        title: title,
        description: description,
        createdAt: DateTime.now(),
      );
      await _createTodoTaskUsecase.execute(taskEntity);
      emit(CreateTaskSuccess());
    } catch (e) {
      emit(const CreateTaskFailure(message: 'Ops. Something when wrong!'));
    }
  }
}
