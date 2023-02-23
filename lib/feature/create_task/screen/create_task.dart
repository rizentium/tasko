import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/core/extension/context.dart';
import 'package:tasko/feature/create_task/cubit/create_task_cubit.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTaskCubit(),
      child: const _CreateTaskScreen(),
    );
  }
}

class _CreateTaskScreen extends StatelessWidget {
  const _CreateTaskScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTaskCubit, CreateTaskState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Create New Task',
                      style: context.textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                const TextField(
                  decoration: InputDecoration(hintText: 'Title'),
                ),
                const SizedBox(height: 12.0),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Description',
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 12.0),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
