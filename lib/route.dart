import 'package:flutter/material.dart';
import 'package:movie_app/presentation/pages/landing_page.dart';
import 'package:movie_app/presentation/screens/login_screen.dart';
import 'package:movie_app/presentation/screens/sign_up_screen.dart';

class AppRoutes {
  static const String landing = '/';
  static const String signUp = '/signup';
  static const String login = '/login';
  static const String home = '/home';
  static const String movieDetails = '/movieDetails';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      landing: (context) => LandingPage(),
      signUp: (context) => const SignUpScreen(),
      login: (context) => const LoginScreen(),
      // home: (context) => const HomeScreen(),
      // movieDetails: (context) => const MovieDetailsScreen(),
    };
  }
}
