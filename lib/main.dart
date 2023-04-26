import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter_clone/core/injections/injection_setup.dart';
import 'package:twitter_clone/domain/app_db/app_db_repository.dart';
import 'package:twitter_clone/presentation/bloc/auth/auth_bloc.dart';
import 'package:twitter_clone/presentation/router/router.dart';

void main() async {
  await initializeAppDependancies();
  runApp(const MyApp());
}

Future<void> initializeAppDependancies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  await getIt<AppDbRepository>().initializeDB();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<AuthBloc>())],
      child: ScreenUtilInit(
          designSize: const Size(360, 900),
          splitScreenMode: true,
          minTextAdapt: true,
          builder: (context, child) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: AppRouter.SPLASH_SCREEN,
              onGenerateRoute: AppRouter.onGeneratedRoute,
            );
          }),
    );
  }
}
