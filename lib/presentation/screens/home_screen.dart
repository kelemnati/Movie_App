import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movie_app/blocs/authentication/authentication_bloc.dart';
import 'package:movie_app/blocs/bottom_navigation/bottom_nav_cubit.dart';
import 'package:movie_app/blocs/movie_feature/movie_feature_bloc.dart';
import 'package:movie_app/blocs/theme/theme_cubit.dart';
import 'package:movie_app/config/themes/app_theme.dart';
import 'package:movie_app/presentation/screens/like_screen.dart';
import 'package:movie_app/presentation/screens/profile_screen.dart';
import 'package:movie_app/presentation/screens/search_screen.dart';
import 'package:movie_app/presentation/widgets/common_widgets.dart';
import 'package:movie_app/presentation/widgets/movie_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;

    // Define the pages for navigation
    final List<Widget> pages = [
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<MovieFeatureBloc, MovieFeatureState>(
              builder: (context, state) {
                final isLoading =
                    context.read<MovieFeatureBloc>().state is MovieLoading;
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieLoaded) {
                  return MovieSection(
                    title: 'Popular Movies',
                    movies: state.movie,
                  );
                } else if (state is MovieError) {
                  return Center(child: Text(state.message));
                } else {
                  context.read<MovieFeatureBloc>().add(FetchPopularMovies());
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<MovieFeatureBloc, MovieFeatureState>(
              builder: (context, state) {
                if (state is MovieLoaded) {
                  return MovieSection(
                    title: 'Trending Movies',
                    movies: state.movie,
                  );
                } else if (state is MovieError) {
                  return Center(child: Text(state.message));
                } else {
                  context.read<MovieFeatureBloc>().add(FetchTrendingMovies());
                  return const SizedBox.shrink();
                }
              },
            ),
            const VerticalSpacer(height: 16),
            BlocBuilder<MovieFeatureBloc, MovieFeatureState>(
              builder: (context, state) {
                if (state is MovieLoaded) {
                  return MovieSection(
                    title: 'Top Rated Movies',
                    movies: state.movie,
                  );
                } else if (state is MovieError) {
                  return Center(child: Text(state.message));
                } else {
                  context.read<MovieFeatureBloc>().add(FetchTopRatedMovies());
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
      const LikeScreen(),
      const SearchScreen(),
      const ProfileScreen(),
    ];

    // Fetch username
    final userName = context.select<AuthenticationBloc, String?>(
      (bloc) {
        if (bloc.state is AuthSuccess) {
          final name = (bloc.state as AuthSuccess).userName;
          return name.isNotEmpty
              ? '${name[0].toUpperCase()}${name.substring(1)}'
              : "User";
        }
        return "User";
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/account.png"),
        ),
        title: Text(
          "Welcome $userName",
          style: typography.headlineSmall,
        ),
        actions: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return IconButton(
                icon: Icon(
                  themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color: themeMode == ThemeMode.dark
                      ? Colors.yellow
                      : Colors.grey[800],
                ),
                onPressed: () {
                  context
                      .read<ThemeCubit>()
                      .toggleTheme(themeMode != ThemeMode.dark);
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return pages[state]; // Display page based on state
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return GNav(
            gap: 8,
            selectedIndex: state,
            onTabChange: (index) {
              context.read<BottomNavCubit>().changeTab(index);
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.favorite_border,
                text: "Likes",
              ),
              GButton(
                icon: Icons.search,
                text: "Search",
              ),
              GButton(
                icon: Icons.person,
                text: "Profile",
              ),
            ],
          );
        },
      ),
    );
  }
}
