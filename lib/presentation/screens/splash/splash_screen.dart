import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/presentation/bloc/auth/auth_bloc.dart';
import 'package:twitter_clone/presentation/router/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _loadAuth();
    super.initState();
  }

  _loadAuth() async {
    await Future.delayed(const Duration(seconds: 3))
        .then((value) => context.read<AuthBloc>().add(LoadAuthFromDb(context)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          AppNavigator.pushReplacement(
              context: context, screenName: AppRouter.HOME_SCREEN);
        }

        if (state is AuthNotFound) {
          AppNavigator.pushReplacement(
              context: context, screenName: AppRouter.LOGIN_SCREEN);
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
