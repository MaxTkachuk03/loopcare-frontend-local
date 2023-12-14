import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'app_colors.dart';
part 'theme_constants.dart';
part 'button_styles.dart';

final ThemeData appThemeData = ThemeData(
  useMaterial3: true,
  fontFamily: ThemeConstants.openSansFontFamily,
  colorScheme: _getColorScheme(),
  appBarTheme: _getAppBarTheme(),
  inputDecorationTheme: _getInputDecorationTheme(),
  elevatedButtonTheme: _getElevatedButtonTheme(),
  outlinedButtonTheme: _getOutlinedButtonTheme(),
  tabBarTheme: _getTabBarTheme(),
  textTheme: _getTextTheme(),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.black),
  checkboxTheme: _getCheckboxTheme(),
  highlightColor: Colors.transparent,
  disabledColor: AppColors.greyMid,
);

ColorScheme _getColorScheme() {
  return const ColorScheme(
    primary: AppColors.darkGreen,
    secondary: AppColors.black,
    background: AppColors.bgGreen,
    surface: AppColors.white,
    onBackground: AppColors.darkGreen,
    error: AppColors.red,
    onError: AppColors.darkGreen,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.darkGreen,
    brightness: Brightness.light,
  );
}

AppBarTheme _getAppBarTheme() => const AppBarTheme(
      titleTextStyle: TextStyle(fontSize: ThemeConstants.fontSize18, fontWeight: FontWeight.w600),
      centerTitle: true,
    );

InputDecorationTheme _getInputDecorationTheme() {
  return const InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    contentPadding: EdgeInsets.all(16.0),
    prefixIconColor: AppColors.greyMid,
    errorStyle: TextStyle(
      color: AppColors.red,
      fontWeight: FontWeight.w600,
      fontSize: ThemeConstants.fontSize14,
    ),
    hintStyle: TextStyle(
      color: AppColors.grey,
      fontSize: ThemeConstants.fontSize16,
      fontWeight: FontWeight.w400,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: AppColors.yellowLight,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: AppColors.yellowLight,
        width: 2.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: AppColors.yellowLight,
        width: 2.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: AppColors.yellowLight,
        width: 2.0,
      ),
    ),
  );
}

ElevatedButtonThemeData _getElevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all(ButtonStyles.primarySize),
      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25.0, vertical: 14.0)),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.greyMid;
          }

          return AppColors.blueDark;
        },
      ),
      foregroundColor: MaterialStateProperty.all(AppColors.white),
      textStyle: MaterialStateProperty.all(ButtonStyles.primaryLabel),
    ),
  );
}

OutlinedButtonThemeData _getOutlinedButtonTheme() {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(width: 2.0),
      minimumSize: ButtonStyles.primarySize,
      textStyle: ButtonStyles.outlinedLabel,
      foregroundColor: AppColors.blueDarker,
    ),
  );
}

TabBarTheme _getTabBarTheme() {
  return TabBarTheme(
    labelColor: AppColors.black,
    labelStyle: const TextStyle(
      fontSize: ThemeConstants.fontSize14,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelColor: AppColors.grey,
    unselectedLabelStyle: const TextStyle(
      fontSize: ThemeConstants.fontSize14,
      fontWeight: FontWeight.w600,
    ),
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(6.0),
      color: AppColors.white,
    ),
  );
}

CheckboxThemeData _getCheckboxTheme() {
  return CheckboxThemeData(
    fillColor: MaterialStateProperty.all(
      AppColors.greenLight,
    ),
    checkColor: MaterialStateProperty.all(
      AppColors.white,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(4.0),
      ),
    ),
    side: const BorderSide(width: 1.0, color: AppColors.darkGreen),
  );
}

TextTheme _getTextTheme() {
  return const TextTheme(
    bodyLarge: TextStyle(
      color: AppColors.darkGreen,
      fontSize: ThemeConstants.fontSize18,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: AppColors.darkGreen,
      fontSize: ThemeConstants.fontSize16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: AppColors.darkGreen,
      fontSize: ThemeConstants.fontSize14,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: AppColors.darkGreen,
      fontSize: ThemeConstants.fontSize78,
      fontFamily: ThemeConstants.bitterFontFamily,
      fontWeight: FontWeight.w600,
    ),
    displayMedium: TextStyle(
      color: AppColors.darkGreen,
      fontSize: ThemeConstants.fontSize48,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: AppColors.darkGreen,
      fontSize: ThemeConstants.fontSize32,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      color: AppColors.darkGreen,
      fontSize: ThemeConstants.fontSize28,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      color: AppColors.darkGreen,
      fontSize: ThemeConstants.fontSize18,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      color: AppColors.darkGreen,
      fontSize: ThemeConstants.fontSize16,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      color: AppColors.black,
      fontSize: ThemeConstants.fontSize16,
      fontWeight: FontWeight.w400,
    ),
  );
}
