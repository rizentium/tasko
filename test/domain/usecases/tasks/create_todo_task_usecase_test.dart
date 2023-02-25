import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tasko/data/repositories/task/task.mocks.dart';
import 'package:tasko/domain/usecases/tasks/create_todo_task_usecase.dart';

import '../../../__mocks__/tasks.dart';

void main() {
  test('CreateTodoTaskUsecase should be worked correctly', () async {
    final mockTaskRepository = MockTaskRepository();

    when(mockTaskRepository.create(getTask)).thenAnswer((_) => Future.value());

    final usecase = CreateTodoTaskUsecase(taskRepository: mockTaskRepository);

    await usecase.execute(getTask);
    verify(mockTaskRepository.create(getTask)).called(1);
  });
}
