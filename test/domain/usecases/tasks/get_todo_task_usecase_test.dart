import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tasko/data/repositories/task/task.mocks.dart';
import 'package:tasko/domain/usecases/tasks/get_todo_task_usecase.dart';

import '../../../__mocks__/tasks.dart';

void main() {
  test('CreateTodoTaskUsecase should be worked correctly', () async {
    final mockTaskRepository = MockTaskRepository();

    when(mockTaskRepository.read()).thenAnswer(
      (_) => Future.value(getTaskList),
    );

    final usecase = GetTodoTaskUsecase(taskRepository: mockTaskRepository);

    await usecase.execute();
    verify(mockTaskRepository.read()).called(1);
  });
}
