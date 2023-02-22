import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasko/core/design_system/assets/images.dart';
import 'package:tasko/core/extension/context.dart';
import 'package:tasko/domain/usecases/user/signin_user_usecase.dart';
import 'package:tasko/feature/login/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  final SignInUserUsecase _signInUserUsecase;
  final void Function(BuildContext) onSuccess;

  const LoginScreen({
    super.key,
    required SignInUserUsecase signInUserUsecase,
    required this.onSuccess,
  }) : _signInUserUsecase = signInUserUsecase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(signInUserUsecase: _signInUserUsecase),
      child: _LoginScreen(
        onSuccess: onSuccess,
      ),
    );
  }
}

class _LoginScreen extends StatelessWidget {
  final void Function(BuildContext) onSuccess;

  const _LoginScreen({required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            onSuccess.call(context);
          }

          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'tasko',
                    style: context.textTheme.displaySmall?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                  const Text('Put every notes in single app'),
                  const SizedBox(height: 64),
                  OutlinedButton.icon(
                    icon: Image.asset(ImageAssets.g, width: 24),
                    label: const Text('Login with Google'),
                    onPressed: () =>
                        context.read<LoginCubit>().signInWithGoogle(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
