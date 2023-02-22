import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/feature/home/cubit/dashboard_cubit.dart';
import 'package:tasko/feature/home/screen/dashboard_done.dart';
import 'package:tasko/feature/home/screen/dashboard_in_progress.dart';
import 'package:tasko/feature/home/screen/dashboard_todo.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(),
      child: const _DashboardScreen(),
    );
  }
}

class _DashboardScreen extends StatelessWidget {
  const _DashboardScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(tabs: state.getTabs()),
              title: const Text('Your Current Tasks'),
            ),
            body: TabBarView(children: state.getScreens()),
          ),
        );
      },
    );
  }
}
