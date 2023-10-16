import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xff4838D1),
    buttonTheme: const ButtonThemeData(buttonColor: Color(0x004838D1)),
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: Color(0xff4838D1),
      onPrimary: Color(0xff2E2E5D),
      secondary: Color(0xffB8B8C7),
      background: Colors.white,
      onBackground: Colors.white,
      surface: Color(0xffF5F5FA),
      onSurface: Color(0xffB8B8C7),
      error: Color(0xffF77A55),
      onError: Colors.red,
      onSecondary: Color(0xffF5F5FA),
      primaryContainer: Color(0xff4838D1),
      outline: Color(0xff4838D1)
    ));

    
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff0F0F29),
    primaryColor: const Color(0xff4838D1),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff4838D1),
      onPrimary: Color(0xffF5F5FA),
      secondary: Color(0xffB8B8C7),
      background: Color(0xff0F0F29),
      onBackground: Colors.white,
      surface: Color(0xff1C1C4D),
      onSurface: Color(0xff6A6A8B),
      error: Color(0xffF77A55),
      onError: Colors.red,
      onSecondary: Color(0xffF5F5FA),
      primaryContainer: Colors.white,
      outline: Colors.white
    ));
