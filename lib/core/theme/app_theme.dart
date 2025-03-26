import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/app_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    // primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundlightBule,
    // primaryColorLight: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundlightBule,
      titleTextStyle: AppStyles.medium500(color: AppColors.blackColor)
          .copyWith(fontSize: 16.sp),
    ),
    cardTheme: CardTheme(
      color: AppColors.whiteColor.withValues(alpha: 0.5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppColors.colorGrey500.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: AppStyles.regular400(color: AppColors.blackColor).copyWith(
        fontSize: 22,
        letterSpacing: 0,
      ),
      bodySmall: AppStyles.regular400(color: AppColors.blackColor).copyWith(
        fontSize: 12,
      ),
      bodyMedium: AppStyles.regular400(color: AppColors.blackColor).copyWith(
        fontSize: 14,
      ),
      labelSmall: AppStyles.medium500(color: AppColors.blackColor).copyWith(
        fontSize: 11,
      ),
      labelMedium: AppStyles.medium500(color: AppColors.blackColor).copyWith(
        fontSize: 12,
      ),
      labelLarge: AppStyles.medium500(color: AppColors.blackColor).copyWith(
        fontSize: 14,
      ),
      titleSmall: AppStyles.medium500(color: AppColors.blackColor).copyWith(
        fontSize: 14,
        letterSpacing: 0.1,
      ),
      titleMedium: AppStyles.medium500(color: AppColors.blackColor).copyWith(
        fontSize: 16,
        letterSpacing: 0.15,
      ),
      titleLarge: AppStyles.medium500(color: AppColors.blackColor).copyWith(
        fontSize: 22,
        letterSpacing: 0,
      ),
    ),
    hintColor: AppColors.hintColor,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          AppStyles.medium500(color: AppColors.blackColor).copyWith(
            fontSize: 14,
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(AppColors.blackColor),
        backgroundColor: WidgetStatePropertyAll(AppColors.primaryBlue),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.blackColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blackColor,
      titleTextStyle: AppStyles.medium500(color: AppColors.whiteColor).copyWith(
        fontSize: 16,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          AppStyles.medium500(color: AppColors.whiteColor).copyWith(
            fontSize: 14,
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(AppColors.whiteColor),
        backgroundColor: WidgetStatePropertyAll(AppColors.primaryBlue),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: AppStyles.regular400(color: AppColors.whiteColor).copyWith(
        fontSize: 22,
        letterSpacing: 0,
      ),
      bodySmall: AppStyles.regular400(color: AppColors.whiteColor).copyWith(
        fontSize: 12,
      ),
      bodyMedium: AppStyles.regular400(color: AppColors.whiteColor).copyWith(
        fontSize: 14,
      ),
      labelSmall: AppStyles.medium500(color: AppColors.whiteColor).copyWith(
        fontSize: 11,
      ),
      labelMedium: AppStyles.medium500(color: AppColors.whiteColor).copyWith(
        fontSize: 12,
      ),
      labelLarge: AppStyles.medium500(color: AppColors.whiteColor).copyWith(
        fontSize: 14,
      ),
      titleSmall: AppStyles.medium500(color: AppColors.whiteColor).copyWith(
        fontSize: 14,
        letterSpacing: 0.1,
      ),
      titleMedium: AppStyles.medium500(color: AppColors.whiteColor).copyWith(
        fontSize: 16,
        letterSpacing: 0.15,
      ),
      titleLarge: AppStyles.medium500(color: AppColors.whiteColor).copyWith(
        fontSize: 22,
        letterSpacing: 0,
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.colorGrey500.withValues(alpha: 0.5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppColors.whiteColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
    ),
    hintColor: AppColors.hintColor,
  );
}
