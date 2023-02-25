import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/feature/dashboard/bloc/dashboard_in_progress/dashboard_in_progress_cubit.dart';

class DashboardInProgressScreen extends StatelessWidget {
  const DashboardInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardInProgressCubit(),
      child: _DashboardInProgressScreen(),
    );
  }
}

class _DashboardInProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardInProgressCubit, DashboardInProgressState>(
      listener: (context, state) {},
      child: BlocBuilder<DashboardInProgressCubit, DashboardInProgressState>(
        builder: (context, state) {
          return const Scaffold(
            body: Center(
              child: Text('DashboardInProgressScreen'),
            ),
          );
        },
      ),
    );
  }
}
