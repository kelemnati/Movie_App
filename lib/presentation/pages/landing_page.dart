import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/content_model.dart';
import 'package:movie_app/blocs/onboarding/onboarding_cubit.dart';
import 'package:movie_app/config/themes/app_theme.dart';

import 'package:movie_app/route.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<OnboardingCubit, int>(
              builder: (context, currentPage) {
                return PageView.builder(
                  controller: _pageController,
                  key: const PageStorageKey(
                      'onboardingPageView'), // Add a unique key for the PageView
                  itemCount: contetns.length,
                  onPageChanged: (index) {
                    context.read<OnboardingCubit>().setPage(index);
                  },
                  itemBuilder: (_, i) {
                    return Padding(
                      key: ValueKey(
                          i), // Provide a unique ValueKey for each child
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
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          BlocBuilder<OnboardingCubit, int>(
            builder: (context, currentPage) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contetns.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: currentPage == index ? 12 : 8,
                    width: currentPage == index ? 12 : 8,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: currentPage == index
                          ? theme.primary
                          : theme.secondaryText.withOpacity(0.5),
                    ),
                  ),
                ),
              );
            },
          ),
          BlocBuilder<OnboardingCubit, int>(
            builder: (context, currentPage) {
              final cubit = context.read<OnboardingCubit>();
              return Container(
                height: 55,
                width: double.infinity,
                margin: const EdgeInsets.all(40),
                child: ElevatedButton(
                  child: Text(
                    cubit.isLastPage ? "Get Started" : "Next",
                    style: typography.labelLarge,
                  ),
                  onPressed: () {
                    if (cubit.isLastPage) {
                      Navigator.pushNamed(context, AppRoutes.signUp);
                    } else {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                      cubit.nextPage();
                    }
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
