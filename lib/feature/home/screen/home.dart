import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasko/domain/usecases/user/get_user_usacase.dart';
import 'package:tasko/feature/home/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  final GetUserUsecase _getUserUsecase;
  final Widget _profileScreen;
  final Widget _dashboardScreen;
  final Widget _createTaskScreen;
  final String onUnauthorizedUrl;

  const HomeScreen({
    super.key,
    required GetUserUsecase getUserUsecase,
    required Widget profileScreen,
    required Widget dashboardScreen,
    required Widget createTaskScren,
    required this.onUnauthorizedUrl,
  })  : _getUserUsecase = getUserUsecase,
        _profileScreen = profileScreen,
        _dashboardScreen = dashboardScreen,
        _createTaskScreen = createTaskScren;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        getUserUsecase: _getUserUsecase,
        profileScreen: _profileScreen,
        dashboardScreen: _dashboardScreen,
      ),
      child: _HomeScreen(
        onUnauthorizedUrl: onUnauthorizedUrl,
        createTaskScreen: _createTaskScreen,
      ),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  final String onUnauthorizedUrl;
  final Widget createTaskScreen;

  const _HomeScreen({
    required this.onUnauthorizedUrl,
    required this.createTaskScreen,
  });

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<HomeCubit>().initialize(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeUnauthorized) {
          context.go(widget.onUnauthorizedUrl);
        }
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeChanged) {
            return Scaffold(
              body: state.navigationItems[state.currentIndex].screen,
              floatingActionButton: FloatingActionButton(
                onPressed: () => _onCreateTaskPressed(context),
                child: const Icon(Icons.add),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomNavigationBar(
                items: state.navigationItemList,
                currentIndex: state.currentIndex,
                onTap: context.read<HomeCubit>().onUpdateNavigationItem,
              ),
            );
          }

          return const Scaffold(
            body: Center(
              child: Text('Unauthorized'),
            ),
          );
        },
      ),
    );
  }

  Future<void> _onCreateTaskPressed(BuildContext context) =>
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return widget.createTaskScreen;
        },
      );
}
