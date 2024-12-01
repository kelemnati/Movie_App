import 'package:flutter/material.dart';
import 'package:movie_app/config/themes/app_theme.dart';
import 'package:movie_app/route.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;

    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/image_one.jpg"),
                      fit: BoxFit.cover)),
            )),
        Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Movie App",
                  style: typography.headlineLarge,
                ),
                const SizedBox(height: 16),
                Text(
                    'Discover movies, create your favorites list, and enjoy personalized recommendations.',
                    textAlign: TextAlign.center,
                    style: typography.bodyLargeWhite),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signUp);
                  },
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(theme.radius),
                      ),
                    ),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: typography.labelLarge,
                  ),
                )
              ],
            ))
      ],
    ));
  }
}
