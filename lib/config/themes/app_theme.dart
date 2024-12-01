import 'package:flutter/material.dart';
import 'package:movie_app/config/themes/theme_data_factory.dart';
import 'app_typography.dart';

abstract class AppTheme {
  static AppTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  late Brightness brightness;
  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color tertiaryText;
  late Color primaryBackground;
  late Color secondaryBackground;

  late LinearGradient primaryBackgroundGradient;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color accent5;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;
  late double radius;

  late Color primaryBtnText;
  late Color lineColor;
  late Color cardBackground;
  late Color cardText;
  late List<Color> cardBackgroundColors;
  late Color skeletonBaseHighlightColor;
  late Color unClickedColor;
  late Color bottomNavBar;

  late Color circularCardBackground;
  late Color inputFieldBorder;
  late Color inputFieldBackground;
  late Color textButtonColor;
  late Color appBarColor;

  AppTypography get typography => ThemeTypography(this);
  ThemeData get themeData => ThemeDataFactory.toThemeData(this);
}

class LightModeTheme extends AppTheme {
  @override
  Brightness get brightness => Brightness.light;
  @override
  Color get primary => const Color(0xFF6200EA);
  @override
  Color get secondary => const Color(0xFF03DAC6);
  @override
  Color get tertiary => const Color(0xFF018786);
  @override
  Color get alternate => const Color(0xFFBB86FC);

  @override
  Color get primaryText => const Color(0xFFB0BEC5); // Grey 400
  @override
  Color get secondaryText => const Color(0xFF546E7A); // Dark Grey
  @override
  Color get tertiaryText => const Color(0xFF757575);

  @override
  Color get primaryBackground => const Color(0xFFFFFFFF); // White
  @override
  LinearGradient get primaryBackgroundGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFFFFF), Color(0xFFF5F5F5)],
      );

  @override
  Color get secondaryBackground => const Color(0xFFF5F5F5); // Light Grey
  @override
  Color get accent1 => const Color(0xFFF3F4F6);
  @override
  Color get accent2 => const Color(0xFF999999);
  @override
  Color get accent3 => const Color(0xFFF4F2EE);
  @override
  Color get accent4 => const Color(0xCCFFFFFF);
  @override
  Color get accent5 => const Color(0xFF808080);
  @override
  Color get success => const Color(0xFF388E3C);
  @override
  Color get warning => const Color(0xFFFBC02D);
  @override
  Color get error => const Color(0xFFD32F2F);
  @override
  Color get info => const Color(0xFF1976D2);
  @override
  double get radius => 40;

  @override
  Color get primaryBtnText => const Color(0xFFFFFFFF);
  @override
  Color get lineColor => Colors.black12;
  @override
  Color get cardBackground => const Color(0xFFEEEEEE);
  @override
  Color get cardText => const Color(0xFF333333);
  @override
  Color get bottomNavBar => const Color(0xFFE0E0E0);
  @override
  Color get skeletonBaseHighlightColor => const Color(0xFFE0E0E0);
  @override
  Color get unClickedColor => accent2;
  @override
  Color get circularCardBackground => const Color(0xFFEEEEEE);
  @override
  Color get inputFieldBorder => const Color(0xFFCCCCCC);
  @override
  Color get textButtonColor => const Color(0xFF1976D2);
  @override
  Color get inputFieldBackground => const Color(0xFFFFFFFF);
}

class DarkModeTheme extends AppTheme {
  @override
  Brightness get brightness => Brightness.dark;
  @override
  Color get primary => const Color(0xFF121212);
  @override
  Color get secondary => const Color(0xFFEB5B00);
  @override
  Color get tertiary => const Color(0xFFBB86FC);
  @override
  Color get alternate => const Color(0xFF3700B3);

  @override
  Color get primaryText => const Color(0xFFEB5B00); // Orange
  @override
  Color get secondaryText => const Color(0xFFFA8C00); // Light Orange
  @override
  Color get tertiaryText => const Color(0xFFF57C00);

  @override
  Color get primaryBackground => const Color(0xFF000000); // Black
  @override
  LinearGradient get primaryBackgroundGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF000000), Color(0xFF121212)],
      );

  @override
  Color get secondaryBackground => const Color(0xFF121212); // Dark Grey
  @override
  Color get accent1 => const Color(0xFF1E1E1E);
  @override
  Color get accent2 => const Color(0xFF3C3C3C);
  @override
  Color get accent3 => const Color(0xFF1C1C1C);
  @override
  Color get accent4 => const Color(0xCC121212);
  @override
  Color get accent5 => const Color(0xFF2E2E2E);
  @override
  Color get success => const Color(0xFF00E676);
  @override
  Color get warning => const Color(0xFFFFC400);
  @override
  Color get error => const Color(0xFFD50000);
  @override
  Color get info => const Color(0xFF1E88E5);
  @override
  double get radius => 40;

  @override
  Color get primaryBtnText => const Color(0xFFFFFFFF);
  @override
  Color get lineColor => Colors.black54;
  @override
  Color get cardBackground => const Color(0xFF1E1E1E);
  @override
  Color get cardText => const Color(0xFFFFFFFF);
  @override
  Color get bottomNavBar => const Color(0xFF1C1C1C);
  @override
  Color get skeletonBaseHighlightColor => const Color(0xFF2C2C2C);
  @override
  Color get unClickedColor => accent2;
  @override
  Color get circularCardBackground => const Color(0xFF2C2C2C);
  @override
  Color get inputFieldBorder => const Color(0xFF3C3C3C);
  @override
  Color get textButtonColor => const Color(0xFFEB5B00);
  @override
  Color get inputFieldBackground => const Color(0xFF121212);
}
