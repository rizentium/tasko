import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/design_system/ui/appbar_close.dart';
import 'package:tasko/core/design_system/ui/text_field.dart';
import 'package:tasko/core/extension/context.dart';
import 'package:tasko/domain/usecases/tasks/create_todo_task_usecase.dart';
import 'package:tasko/feature/task_create/cubit/create_task_cubit.dart';

class TaskCreateScreen extends StatelessWidget {
  final CreateTodoTaskUsecase _createTodoTaskUsecase;

  const TaskCreateScreen({
    super.key,
    required CreateTodoTaskUsecase createTodoTaskUsecase,
  }) : _createTodoTaskUsecase = createTodoTaskUsecase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCreateCubit(
        createTodoTaskUsecase: _createTodoTaskUsecase,
      ),
      child: const _TaskCreateScreen(),
    );
  }
}

class _TaskCreateScreen extends StatefulWidget {
  const _TaskCreateScreen();

  @override
  State<_TaskCreateScreen> createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<_TaskCreateScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _titleValidation = ValueNotifier<bool>(false);
  final _descriptionValidation = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCreateCubit, TaskCreateState>(
      listener: (context, state) {
        if (state is TaskCreateFailure) {
          context.showSnackBar(message: state.message);
        }

        if (state is TaskCreateSuccess) {
          context.pop();
        }
      },
      child: BlocBuilder<TaskCreateCubit, TaskCreateState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBarClose(
              context: context,
              title: const Text('Create New Task'),
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

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  _onSavePressed(BuildContext context) {
    context.read<TaskCreateCubit>().create(
          title: _titleController.text,
          description: _descriptionController.text,
        );
  }
}
