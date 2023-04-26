// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:twitter_clone/presentation/screens/home/home_screen.dart';
import 'package:twitter_clone/presentation/screens/login/login_screen.dart';
import 'package:twitter_clone/presentation/screens/signup/signup_screen.dart';
import 'package:twitter_clone/presentation/screens/splash/splash_screen.dart';
part 'app_navigator.dart';

class AppRouter {
  static const SPLASH_SCREEN = "/";
  static const LOGIN_SCREEN = "login/";
  static const SIGNUP_SCREEN = "signup/";
  static const VERIFICATION_SCREEN = "verification/";
  static const HOME_SCREEN = "home/";
  static const NEW_USER_SCREEN = "newuser/";

  static Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_SCREEN:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case SIGNUP_SCREEN:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );

      case HOME_SCREEN:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case SPLASH_SCREEN:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      // case VERIFICATION_SCREEN:
      //   return MaterialPageRoute(
      //     builder: (context) => const VerificationScreen(),
      //   );

      // case HOME_SCREEN:
      //   return MaterialPageRoute(
      //     builder: (context) => const HomeScreen(),
      //   );
      // case NEW_USER_SCREEN:
      //   return MaterialPageRoute(
      //     builder: (context) => const NewUserScreen(),
      //   );

      default:
        return null;
    }
  }
}
