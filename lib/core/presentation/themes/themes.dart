import 'package:flutter/material.dart';

part 'app_colors.dart';
part 'button_styles.dart';
part 'tab_bar_styles.dart';
part 'theme_constants.dart';

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
  chipTheme: _chipTheme(),
  highlightColor: Colors.transparent,
  disabledColor: AppColors.greyMid,
  bottomNavigationBarTheme: _bottomNavigationBarThemeData(),
  bottomSheetTheme: _bottomSheetTheme(),
  dividerTheme: const DividerThemeData(
    color: AppColors.white,
  ),
  popupMenuTheme: PopupMenuThemeData(
    textStyle: _getPopupMenuTheme(),
  ),
);

BottomSheetThemeData _bottomSheetTheme() {
  return const BottomSheetThemeData(
    backgroundColor: AppColors.white,
    modalBackgroundColor: AppColors.white,
    surfaceTintColor: AppColors.white,
  );
}

BottomNavigationBarThemeData _bottomNavigationBarThemeData() {
  return BottomNavigationBarThemeData(
    backgroundColor: AppColors.blueDarker,
    type: BottomNavigationBarType.fixed,
    unselectedLabelStyle: TextStyle(color: AppColors.white.withOpacity(0.5), fontSize: ThemeConstants.fontSize14),
    selectedLabelStyle:
        const TextStyle(color: AppColors.white, fontSize: ThemeConstants.fontSize14, fontWeight: FontWeight.bold),
    unselectedIconTheme: IconThemeData(color: AppColors.white.withOpacity(0.5)),
    selectedIconTheme: const IconThemeData(color: AppColors.white),
    unselectedItemColor: AppColors.white.withOpacity(0.5),
    selectedItemColor: AppColors.white,
  );
}

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
    labelPadding: const EdgeInsets.symmetric(horizontal: 8),
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
      color: AppColors.white,
    ),
  );
}

ChipThemeData _chipTheme() {
  return const ChipThemeData(
    showCheckmark: false,
    labelStyle: TextStyle(
      fontSize: ThemeConstants.fontSize14,
      fontWeight: FontWeight.w400,
      color: AppColors.blueDarker,
    ),
    secondaryLabelStyle: TextStyle(
      fontSize: ThemeConstants.fontSize14,
      fontWeight: FontWeight.w600,
      color: AppColors.blueDarker,
    ),
    side: BorderSide(width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 25.0),
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
    checkColor: MaterialStateProperty.all(AppColors.white),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
    side: const BorderSide(width: 1.5, color: AppColors.blueRegular),
    materialTapTargetSize: MaterialTapTargetSize.padded,
  );
}

TextStyle? _getPopupMenuTheme() {
  return const TextStyle(
    // Restyled
    color: AppColors.white,
    fontSize: ThemeConstants.fontSize16,
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
      color: AppColors.blueDarker,
      fontSize: ThemeConstants.fontSize32,
    ),
    headlineLarge: TextStyle(
      // Restyled
      color: AppColors.blueDarker,
      fontSize: ThemeConstants.fontSize38,
    ),
    headlineMedium: TextStyle(
      // Restyled
      color: AppColors.blueDarker,
      fontSize: ThemeConstants.fontSize32,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      // Restyled
      color: AppColors.blueDarker,
      fontSize: ThemeConstants.fontSize20,
    ),
    titleLarge: TextStyle(
      // Restyled
      color: AppColors.blueDarker,
      fontSize: ThemeConstants.fontSize18,
    ),
    titleMedium: TextStyle(
      // Restyled
      color: AppColors.blueDarker,
      fontSize: ThemeConstants.fontSize16,
    ),
    titleSmall: TextStyle(
      // Restyled
      color: AppColors.blueDarker,
      fontSize: ThemeConstants.fontSize14,
    ),
  );
}
