import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.lightGrayColor]) =>
      OutlineInputBorder(borderSide: BorderSide(color: color, width: 3), borderRadius: BorderRadius.circular(8));
  static final darkThemeode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.blackColor,
      appBarTheme: const AppBarTheme(backgroundColor: AppPallete.blackColor),
      inputDecorationTheme: InputDecorationTheme(
          border: _border(),
          contentPadding: const EdgeInsets.all(25),
          enabledBorder: _border(),
          focusedBorder: _border(AppPallete.lightOrangeColor),
          errorBorder: _border(AppPallete.greenColor)));
}
