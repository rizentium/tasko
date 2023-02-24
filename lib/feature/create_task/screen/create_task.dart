import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/design_system/ui/appbar_close.dart';
import 'package:tasko/core/design_system/ui/text_field.dart';
import 'package:tasko/core/extension/context.dart';
import 'package:tasko/domain/usecases/tasks/create_todo_task_usecase.dart';
import 'package:tasko/feature/create_task/cubit/create_task_cubit.dart';

class CreateTaskScreen extends StatelessWidget {
  final CreateTodoTaskUsecase _createTodoTaskUsecase;

  const CreateTaskScreen({
    super.key,
    required CreateTodoTaskUsecase createTodoTaskUsecase,
  }) : _createTodoTaskUsecase = createTodoTaskUsecase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTaskCubit(
        createTodoTaskUsecase: _createTodoTaskUsecase,
      ),
      child: const _CreateTaskScreen(),
    );
  }
}

class _CreateTaskScreen extends StatefulWidget {
  const _CreateTaskScreen();

  @override
  State<_CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<_CreateTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _titleValidation = ValueNotifier<bool>(false);
  final _descriptionValidation = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTaskCubit, CreateTaskState>(
      listener: (context, state) {
        if (state is CreateTaskFailure) {
          context.showSnackBar(message: state.message);
        }

        if (state is CreateTaskSuccess) {
          context.pop();
        }
      },
      child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
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
    context.read<CreateTaskCubit>().create(
          title: _titleController.text,
          description: _descriptionController.text,
        );
  }
}
