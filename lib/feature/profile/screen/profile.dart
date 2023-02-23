import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/domain/usecases/user/signout_user_usecase.dart';
import 'package:tasko/feature/profile/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  final SignOutUserUsecase _signOutUserUsecase;
  final String onSignedOutUrl;

  const ProfileScreen({
    required SignOutUserUsecase signOutUserUsecase,
    required this.onSignedOutUrl,
    super.key,
  }) : _signOutUserUsecase = signOutUserUsecase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(signOutUserUsecase: _signOutUserUsecase),
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
        if (state is ProfileSignedOut) {
          context.go(widget.onSignedOutUrl);
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
