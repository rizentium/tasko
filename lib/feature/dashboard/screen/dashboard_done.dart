import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/feature/dashboard/bloc/dashboard_done/dasboard_done_cubit.dart';

class DashboardDoneScreen extends StatelessWidget {
  const DashboardDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DasboardDoneCubit(),
      child: _DashboardDoneScreen(),
    );
  }
}

class _DashboardDoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DasboardDoneCubit, DasboardDoneState>(
      listener: (context, state) {},
      child: BlocBuilder<DasboardDoneCubit, DasboardDoneState>(
        builder: (context, state) {
          return const Scaffold(
            body: Center(
              child: Text('DashboardDoneScreen'),
            ),
          );
        },
      ),
    );
  }
}
