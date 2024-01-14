import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  AppTheme._();

  static final theme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: AppColors.bg,
      errorColor: AppColors.error,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyles.headline1,
      displayMedium: TextStyles.headline2,
      displaySmall: TextStyles.headline3,
      headlineMedium: TextStyles.headline4,
      labelLarge: TextStyles.subtitle,
      bodySmall: TextStyles.caption,
      bodyLarge: TextStyles.bodyRegular,
      bodyMedium: TextStyles.bodyBold,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
