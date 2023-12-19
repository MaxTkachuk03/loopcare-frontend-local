import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'app_colors.dart';
part 'theme_constants.dart';
part 'button_styles.dart';
part 'tab_bar_styles.dart';

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

ElevatedButtonThemeData _getElevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all(ButtonStyles.primarySize),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.greyLight;
          }

          return AppColors.blueRegular;
        },
      ),
      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25.0, vertical: 14.0)),
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
      disabledForegroundColor: AppColors.greyLight,
    ),
  );
}

TabBarTheme _getTabBarTheme() {
  return TabBarTheme(
    labelStyle: TabBarStyles.label,
    unselectedLabelStyle: TabBarStyles.unselectedLabel,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
      color: AppColors.white,
    ),
  );
}

InputDecorationTheme _getInputDecorationTheme() {
  return const InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
    prefixIconColor: AppColors.greyRegular,
    errorStyle: TextStyle(
      color: AppColors.red,
      fontWeight: FontWeight.w600,
      fontSize: ThemeConstants.fontSize14,
    ),
    hintStyle: TextStyle(
      color: AppColors.greyRegular,
      fontSize: ThemeConstants.fontSize16,
      fontWeight: FontWeight.w400,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: AppColors.greyRegular, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: AppColors.greyRegular, width: 2.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: AppColors.red, width: 1.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: AppColors.red, width: 1.0),
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
    bodySmall: TextStyle(
      // Restyled
      color: AppColors.blueDarker,
      fontSize: ThemeConstants.fontSize14,
    ),
    bodyMedium: TextStyle(
      // Restyled
      color: AppColors.blueDarker,
      fontSize: ThemeConstants.fontSize16,
    ),
    bodyLarge: TextStyle(
      // Restyled
      color: AppColors.blueDarker,
      fontSize: ThemeConstants.fontSize18,
    ),
    displayLarge: TextStyle(
      // Restyled
      color: AppColors.blueDarker,
      fontSize: ThemeConstants.fontSize28,
    ),
    displayMedium: TextStyle(
      // Restyled
      color: AppColors.blueDarker,
      fontSize: ThemeConstants.fontSize24,
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
    headlineLarge: TextStyle(
      // Restyled
      color: AppColors.blueDarker,
      fontSize: ThemeConstants.fontSize38,
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
