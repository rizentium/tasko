import 'package:flutter_test/flutter_test.dart';
import 'package:tasko/util/extension/task_list.dart';

import '../../__mocks__/tasks.dart';

void main() {
  test('ListOfTaskExtended should be worked correctly', () {
    final tasks = getTaskList;

    expect(tasks.getToDoList().length, 1);
    expect(tasks.getInProgressList().length, 4);
    expect(tasks.getDoneList().length, 2);
  });
}
