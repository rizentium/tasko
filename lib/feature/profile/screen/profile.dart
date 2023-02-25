import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/core/extension/context.dart';
import 'package:tasko/core/extension/string.dart';
import 'package:tasko/domain/usecases/tasks/export_todo_task_usecase.dart';
import 'package:tasko/domain/usecases/user/get_user_usacase.dart';
import 'package:tasko/domain/usecases/user/signout_user_usecase.dart';
import 'package:tasko/feature/profile/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  final GetUserUsecase _getUserUsecase;
  final SignOutUserUsecase _signOutUserUsecase;
  final ExportTodoTaskUsecase _exportTodoTaskUsecase;
  final String onSignedOutUrl;

  const ProfileScreen({
    required SignOutUserUsecase signOutUserUsecase,
    required GetUserUsecase getUserUsecase,
    required ExportTodoTaskUsecase exportTodoTaskUsecase,
    required this.onSignedOutUrl,
    super.key,
  })  : _getUserUsecase = getUserUsecase,
        _signOutUserUsecase = signOutUserUsecase,
        _exportTodoTaskUsecase = exportTodoTaskUsecase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(
        getUserUsecase: _getUserUsecase,
        exportTodoTaskUsecase: _exportTodoTaskUsecase,
        signOutUserUsecase: _signOutUserUsecase,
      )..initialize(),
      child: _ProfileScreen(onSignedOutUrl: onSignedOutUrl),
    );
  }
}

class _ProfileScreen extends StatefulWidget {
  final String onSignedOutUrl;

  const _ProfileScreen({required this.onSignedOutUrl});

  @override
  State<_ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<_ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          context.showSnackBar(message: state.message);
        }

        if (state is ProfileFileExported) {
          context.showSnackBar(message: 'File exported!');
        }

        if (state is ProfileSignedOut) {
          context.go(widget.onSignedOutUrl);
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final data = state.data;
          return Scaffold(
            appBar: AppBar(
              title: const Text('User Profile'),
            ),
            body: ListView(
              children: [
                if (data?.displayName.isUndefined == false)
                  ListTile(
                    title: const Text('Display Name'),
                    subtitle: Text(data!.displayName!),
                  ),
                if (data?.email.isUndefined == false)
                  ListTile(
                    title: const Text('Email'),
                    subtitle: Text(data!.email!),
                  ),
                if (data?.phoneNumber.isUndefined == false)
                  ListTile(
                    title: const Text('Phone Number'),
                    subtitle: Text(data!.phoneNumber!),
                  ),
                ListTile(
                  title: const Text('Export as CSV File'),
                  onTap: () => context.read<ProfileCubit>().export(),
                ),
                ListTile(
                  title: const Text('Sign Out'),
                  onTap: () => context.read<ProfileCubit>().signOut(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
