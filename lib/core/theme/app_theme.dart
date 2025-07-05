import 'package:flutter/material.dart';
import 'package:ticket_booking_app/core/constants/app_colors.dart';

/// ## AppTheme
/// A sealed class for App Theme.
sealed class AppTheme {
  static final light = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        fixedSize: Size(double.infinity, 50),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: Colors.transparent,
      enableFeedback: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: AppColors.grayColor,
      selectedIconTheme: IconThemeData(color: Colors.white),
      unselectedIconTheme: IconThemeData(color: AppColors.grayColor),
      selectedLabelStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: AppColors.grayColor,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.buttonColor,
    ),
  );
}
