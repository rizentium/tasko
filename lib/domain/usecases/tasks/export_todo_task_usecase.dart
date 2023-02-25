import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasko/core/locator/usecase.dart';
import 'package:tasko/data/repositories/task/task.dart';
import 'package:tasko/util/extension/task_list.dart';

class ExportTodoTaskUsecase implements Usecase {
  final TaskRepository _taskRepository;

  ExportTodoTaskUsecase({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  Future<String?> execute() async {
    final items = (await _taskRepository.read()).toCSV();
    return await _exportAsFile(items);
  }

  @override
  Future<void> register(GetIt locator) async {
    locator.registerFactory(
      () => ExportTodoTaskUsecase(taskRepository: locator()),
    );
  }

  Future<String?> _exportAsFile(String input) async {
    final String path = (await getApplicationDocumentsDirectory()).path;

    final String filename =
        '$path/REPORT_${DateTime.now().toIso8601String()}.csv';
    final File file = File(filename);
    await file.writeAsString(input, flush: true);

    return filename;
  }
}
