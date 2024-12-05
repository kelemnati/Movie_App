import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/Data/content_model.dart';
import 'package:movie_app/config/themes/app_theme.dart';

import 'package:movie_app/route.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                itemCount: contetns.length,
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(contetns[i].image, height: 200),
                        Column(
                          children: [
                            Text(
                              contetns[i].title,
                              style: typography.headlineLarge,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              contetns[i].discription,
                              style: typography.displayMedium,
                            )
                          ],
                        )

                        // changed text
                      ],
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                contetns.length,
                (index) => Container(
                      height: 10,
                      width: 10,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: theme.primary),
                    )),
          ),
          Container(
            height: 55,
            width: double.infinity,
            margin: const EdgeInsets.all(40),
            child: ElevatedButton(
              child: Text(
                "Next",
                style: typography.labelLarge,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
    // return Scaffold(
    //     extendBodyBehindAppBar: true,
    //     appBar: AppBar(
    //       backgroundColor: Colors.transparent,
    //       elevation: 0,
    //     ),
    //     body: Column(children: [
    //       Container(
    //         height: screenHeight / 2.9,
    //         width: double.infinity,
    //         decoration: const BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage('assets/images/image_one.jpg'),
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 13,
    //       ),
    //       Text(
    //         "Movie App",
    //         style: typography.headlineLarge,
    //       ),
    //       const SizedBox(height: 10),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Text(
    //             'Discover movies, create your favorites list, and enjoy personalized recommendations.',
    //             style: typography.displayMedium),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(50.0),
    //         child: ElevatedButton(
    //           onPressed: () {
    //             Navigator.pushNamed(context, AppRoutes.signUp);
    //           },
    //           child: Text(
    //             'Get Started',
    //             style: typography.labelMedium,
    //           ),
    //         ),
    //       )
    //     ]));
  }
}
