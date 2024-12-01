import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/theme/theme_cubit.dart';
import 'package:movie_app/config/themes/app_theme.dart';
import 'package:movie_app/config/themes/theme_data_factory.dart';
import 'package:movie_app/route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
          theme: ThemeDataFactory.toThemeData(LightModeTheme()),
          darkTheme: ThemeDataFactory.toThemeData(DarkModeTheme()),
          themeMode: state,
          initialRoute: AppRoutes.landing,
          routes: AppRoutes.getRoutes(),
        );
      },
    );
  }
}
