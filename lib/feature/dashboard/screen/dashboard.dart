import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/core/design_system/controller/loading_controller.dart';
import 'package:tasko/core/extension/context.dart';
import 'package:tasko/domain/usecases/tasks/get_todo_task_usecase.dart';

import '../bloc/dashboard/dashboard_cubit.dart';

class DashboardScreen extends StatelessWidget {
  final GetTodoTaskUsecase _getTodoTaskUsecase;

  const DashboardScreen(
      {super.key, required GetTodoTaskUsecase getTodoTaskUsecase})
      : _getTodoTaskUsecase = getTodoTaskUsecase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(getTodoTaskUsecase: _getTodoTaskUsecase),
      child: const _DashboardScreen(),
    );
  }
}

class _DashboardScreen extends StatefulWidget {
  const _DashboardScreen();

  @override
  State<_DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<_DashboardScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<DashboardCubit>().initialize(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardCubit, DashboardState>(
      listener: (context, state) {
        LoadingController loading = LoadingController(context);

        if (state is DashboardLoading) {
          loading.show();
        } else {
          loading.dismiss();
        }

        if (state is DashboardFailure) {
          context.showSnackBar(message: state.message);
        }
      },
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return DefaultTabController(
            length: state.tabItems.length,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(tabs: state.getTabs()),
                title: const Text('Your Current Tasks'),
              ),
              body: TabBarView(children: state.getScreens()),
            ),
          );
        },
      ),
    );
  }
}
