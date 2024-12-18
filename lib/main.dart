import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/data_provider/data_provider.dart';
import 'package:movie_app/Data/data_provider/user_data_provider.dart';
import 'package:movie_app/Data/repository/movie_repo.dart';
import 'package:movie_app/Data/repository/user_repo.dart';
import 'package:movie_app/app.dart';
import 'package:movie_app/blocs/authentication/authentication_bloc.dart';
import 'package:movie_app/blocs/bottom_navigation/bottom_nav_cubit.dart';
import 'package:movie_app/blocs/movie_feature/movie_feature_bloc.dart';
import 'package:movie_app/blocs/onboarding/onboarding_cubit.dart';
import 'package:movie_app/blocs/theme/theme_cubit.dart';
import 'package:movie_app/blocs/user_feature/user_feature_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final userRepository = UserRepository(userDataProvider: UserDataProvider());
  final movieRepository = MovieRepository(dataProvider: MovieService());

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (context) =>
            AuthenticationBloc(userRepository: userRepository)),
    BlocProvider(create: (context) => OnboardingCubit(3)),
    BlocProvider(create: (context) => ThemeCubit()..loadTheme()),
    BlocProvider(create: (context) => BottomNavCubit()),
    BlocProvider(
        create: (context) =>
            MovieFeatureBloc(movieRepository: movieRepository)),
    BlocProvider(
        create: (context) => UserFeatureBloc(userRepository: userRepository))
  ], child: const MyApp()));
}
