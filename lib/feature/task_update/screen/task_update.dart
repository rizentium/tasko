import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/core/design_system/ui/appbar_close.dart';
import 'package:tasko/core/design_system/ui/text_field.dart';
import 'package:tasko/core/extension/context.dart';
import 'package:tasko/data/entities/task.dart';
import 'package:tasko/domain/usecases/tasks/update_todo_task_usecase.dart';
import 'package:tasko/feature/task_update/cubit/task_update_cubit.dart';

class TaskUpdateScreen extends StatelessWidget {
  final TaskEntity? task;
  final UpdateTodoTaskUsecase _updateTodoTaskUsecase;
  final void Function(BuildContext context) onSuccess;

  const TaskUpdateScreen({
    super.key,
    this.task,
    required UpdateTodoTaskUsecase updateTodoTaskUsecase,
    required this.onSuccess,
  }) : _updateTodoTaskUsecase = updateTodoTaskUsecase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskUpdateCubit(
        updateTodoTaskUsecase: _updateTodoTaskUsecase,
      ),
      child: _TaskUpdateScreen(task: task, onSuccess: onSuccess),
    );
  }
}

class _TaskUpdateScreen extends StatefulWidget {
  final TaskEntity? task;
  final void Function(BuildContext context) onSuccess;

  const _TaskUpdateScreen({
    this.task,
    required this.onSuccess,
  });
  @override
  State<_TaskUpdateScreen> createState() => _TaskUpdateScreenState();
}

class _TaskUpdateScreenState extends State<_TaskUpdateScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleValidation = ValueNotifier<bool>(false);
  final _descriptionValidation = ValueNotifier<bool>(false);

  @override
  void initState() {
    _titleController.text = widget.task?.title ?? '';
    _descriptionController.text = widget.task?.description ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskUpdateCubit, TaskUpdateState>(
      listener: (context, state) {
        if (state is TaskUpdateFailure) {
          context.showSnackBar(message: state.message);
        }

        if (state is TaskUpdateSuccess) {
          widget.onSuccess.call(context);
        }
      },
      child: BlocBuilder<TaskUpdateCubit, TaskUpdateState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBarClose(
              context: context,
              title: const Text('Task Update'),
            ),
            body: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12.0),
                  TaskoTextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      helperText: 'Required',
                    ),
                    validation: _titleValidation,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 12.0),
                  TaskoTextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      helperText: 'Required',
                    ),
                    validation: _descriptionValidation,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 12.0),
                  FilledButton(
                    onPressed: () => _onSavePressed(context),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onSavePressed(BuildContext context) {
    context.read<TaskUpdateCubit>().update(
          widget.task?.copyWith(
            title: _titleController.text,
            description: _descriptionController.text,
          ),
        );
  }
}
