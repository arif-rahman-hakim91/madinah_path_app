import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_text_style.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor:
    AppColors.background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),

    cardTheme: CardThemeData(
      color: AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
        AppRadius.lgRadius,
      ),
    ),

    elevatedButtonTheme:
    ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
        AppColors.primary,
        foregroundColor:
        Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius:
          AppRadius.mdRadius,
        ),
      ),
    ),

    textTheme: TextTheme(
      headlineLarge:
      AppTextStyle.headline,
      titleLarge:
      AppTextStyle.title,
      titleMedium:
      AppTextStyle.subtitle,
      bodyMedium:
      AppTextStyle.body,
      bodySmall:
      AppTextStyle.caption,
    ),
  );
}