import 'package:flutter/material.dart';

class AppStyle{

  final ThemeData themeData; 
  AppStyle({required this.themeData});

  TextStyle get titleTextStyle{
    return TextStyle(
      fontSize: 16, 
      fontWeight: FontWeight.w600,
      color: themeData.colorScheme.onPrimary
    );
  }

  TextStyle get defaultTextStyle{
    return TextStyle(
      fontSize: 14, 
      fontWeight: FontWeight.w400,
      color: themeData.colorScheme.onPrimary
    );
  }

  TextStyle get hintStyle{
    return TextStyle(
      fontSize: 14, 
      fontWeight: FontWeight.w400,
      color: themeData.colorScheme.onSurface
    );
  }

  TextStyle get textButtonPrimary{
    return const TextStyle(
      fontSize: 14, 
      fontWeight: FontWeight.w500,
      color: Colors.white
    );
  }

  TextStyle get textButtonSecond{
    return TextStyle(
      fontSize: 14, 
      fontWeight: FontWeight.w500,
      color: themeData.colorScheme.outline
    );
  }

  TextStyle get textImportant{
    return TextStyle(
      fontSize: 16, 
      fontWeight: FontWeight.w500,
      color: themeData.colorScheme.error
    );
  }

}