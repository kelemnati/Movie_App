import 'package:flutter/material.dart';
import 'package:movie_app/config/themes/app_theme.dart';
import 'package:movie_app/route.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(children: [
          Container(
            height: screenHeight / 2.9,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/image_one.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          Text(
            "Movie App",
            style: typography.headlineLarge,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Discover movies, create your favorites list, and enjoy personalized recommendations.',
                style: typography.displayMedium),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.signUp);
              },
              child: Text(
                'Get Started',
                style: typography.displayMedium,
              ),
            ),
          )
        ]));
  }
}
