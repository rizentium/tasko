import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/domain/usecases/user/signout_user_usecase.dart';
import 'package:tasko/feature/profile/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  final SignOutUserUsecase _signOutUserUsecase;
  final void Function(BuildContext context) onSignedOut;

  const ProfileScreen({
    required SignOutUserUsecase signOutUserUsecase,
    required this.onSignedOut,
    super.key,
  }) : _signOutUserUsecase = signOutUserUsecase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(signOutUserUsecase: _signOutUserUsecase),
      child: _ProfileScreen(onSignedOut: onSignedOut),
    );
  }
}

class _ProfileScreen extends StatefulWidget {
  final void Function(BuildContext) onSignedOut;

  const _ProfileScreen({required this.onSignedOut});

  @override
  State<_ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<_ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSignedOut) {
          widget.onSignedOut.call(context);
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('User Profile'),
            ),
            body: ListView(
              children: [
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
