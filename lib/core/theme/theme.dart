import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Shared Border Styling
  static _border({
    Color color = AppPallete.greyColorLight,
    double width = 1.5,
    double radius = 8.0,
  }) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: width),
    borderRadius: BorderRadius.circular(radius),
  );

  // Responsive Padding Helper
  static EdgeInsets responsivePadding(
    BuildContext context, {
    double mobileHorizontal = 16.0,
    double tabletHorizontal = 32.0,
    double desktopHorizontal = 64.0,
    double mobileVertical = 16.0,
    double tabletVertical = 32.0,
    double desktopVertical = 64.0,
  }) {
    final width = MediaQuery.of(context).size.width;
    double horizontal;
    double vertical;

    if (width < 600) {
      horizontal = mobileHorizontal;
      vertical = mobileVertical;
    } else if (width < 1200) {
      horizontal = tabletHorizontal;
      vertical = tabletVertical;
    } else {
      horizontal = desktopHorizontal;
      vertical = desktopVertical;
    }

    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  // Responsive Font Size Helper
  static double responsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    return baseSize * (width / 1440); // Scale relative to 1440px base
  }

  // --- Dark Theme ---
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.darkBackground,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppPallete.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppPallete.whiteColor),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppPallete.blueColor, // Updated to blue
      secondary: AppPallete.blueColor, // Updated to blue
      surface: AppPallete.darkGreyLight,
      onPrimary: AppPallete.whiteColor,
      onSecondary: AppPallete.whiteColor,
      onSurface: AppPallete.whiteColor,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppPallete.whiteColor),
      bodyLarge: TextStyle(color: AppPallete.whiteColor),
      bodySmall: TextStyle(color: AppPallete.greyColor),
      titleLarge: TextStyle(
        color: AppPallete.whiteColor,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: AppPallete.whiteColor,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(color: AppPallete.greyColorLight),
      labelLarge: TextStyle(color: AppPallete.whiteColor),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppPallete.darkGreyLight,
      labelStyle: const TextStyle(color: AppPallete.whiteColor),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppPallete.darkGrey,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 20.0,
      ),
      border: _border(color: AppPallete.greyColorLight),
      enabledBorder: _border(color: AppPallete.greyColorLight),
      focusedBorder: _border(
        color: AppPallete.blueColor,
        width: 2.0,
      ), // Updated to blue
      errorBorder: _border(color: AppPallete.errorColor),
      hintStyle: const TextStyle(color: AppPallete.greyColorLight),
      labelStyle: const TextStyle(color: AppPallete.whiteColor),
      errorStyle: const TextStyle(color: AppPallete.errorColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPallete.blueColor, // Updated to blue
        foregroundColor: AppPallete.whiteColor,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppPallete.blueColor, // Updated to blue
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    iconTheme: const IconThemeData(color: AppPallete.whiteColor),
    primaryIconTheme: const IconThemeData(color: AppPallete.whiteColor),
    cardTheme: CardTheme(
      color: AppPallete.darkGreyLight,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: AppPallete.darkBackground,
      titleTextStyle: TextStyle(
        color: AppPallete.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(color: AppPallete.greyColor),
    ),
  );

  // --- Light Theme ---
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.lightBackground,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppPallete.lightBlack,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppPallete.lightBlack),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppPallete.gradient1, // Updated to blue
      secondary: AppPallete.gradient1, // Updated to blue
      surface: AppPallete.lightGrey,
      onPrimary: AppPallete.whiteColor,
      onSecondary: AppPallete.lightBlack,
      onSurface: AppPallete.lightBlack,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppPallete.lightBlack),
      bodyLarge: TextStyle(color: AppPallete.lightBlack),
      bodySmall: TextStyle(color: AppPallete.lightGreyText),
      titleLarge: TextStyle(
        color: AppPallete.lightBlack,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: AppPallete.lightBlack,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(color: AppPallete.lightGreyText),
      labelLarge: TextStyle(color: AppPallete.lightBlack),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppPallete.lightGrey,
      labelStyle: const TextStyle(color: AppPallete.lightBlack),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppPallete.lightBackground,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 20.0,
      ),
      border: _border(color: AppPallete.lightBorder),
      enabledBorder: _border(color: AppPallete.lightBorder),
      focusedBorder: _border(
        color: AppPallete.gradient1,
        width: 2.0,
      ), // Updated to blue
      errorBorder: _border(color: AppPallete.errorColor),
      hintStyle: const TextStyle(color: AppPallete.lightGreyText),
      labelStyle: const TextStyle(color: AppPallete.lightBlack),
      errorStyle: const TextStyle(color: AppPallete.errorColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPallete.gradient1, // Updated to blue
        foregroundColor: AppPallete.whiteColor,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppPallete.gradient1, // Updated to blue
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    iconTheme: const IconThemeData(color: AppPallete.lightBlack),
    primaryIconTheme: const IconThemeData(color: AppPallete.lightBlack),
    cardTheme: CardTheme(
      color: AppPallete.lightGrey,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: AppPallete.lightBackground,
      titleTextStyle: TextStyle(
        color: AppPallete.lightBlack,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(color: AppPallete.lightGreyText),
    ),
  );
}
