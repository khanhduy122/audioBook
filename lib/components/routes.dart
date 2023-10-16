import 'package:audio_book/screens/comfirm_code_screen.dart';
import 'package:audio_book/screens/finish_screen.dart';
import 'package:audio_book/screens/forget_password_screen.dart';
import 'package:audio_book/screens/home_screen.dart';
import 'package:audio_book/screens/loading_screen.dart';
import 'package:audio_book/screens/main_screen.dart';
import 'package:audio_book/screens/personalization_screen.dart';
import 'package:audio_book/screens/setting_screen.dart';
import 'package:audio_book/screens/signin_screen.dart';
import 'package:audio_book/screens/on_boarding_screen.dart';
import 'package:audio_book/screens/send_email_comfirm_screen.dart';
import 'package:audio_book/screens/signup_screen.dart';
import 'package:audio_book/screens/splash_screen.dart';
import 'package:audio_book/screens/welcom_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.name: (context) => const SplashScreen(),
  OnBoardingScreen.name: (context) => const OnBoardingScreen(),
  SigninScreen.name: (context) => const SigninScreen(),
  SignUpScreen.name: (context) => const SignUpScreen(),
  ComfirmCodeScreen.name: (context) => const ComfirmCodeScreen(),
  ForgetPasswordScreen.name: (context) => const ForgetPasswordScreen(),
  SendEmailComfirmScreen.name: (context) => const SendEmailComfirmScreen(),
  WelcomScreen.name: (context) => const WelcomScreen(),
  HomeScreen.name: (context) => const HomeScreen(),
  PersonalizationScreen.name: (context) => const PersonalizationScreen(),
  FinishScreen.name: (context) => const FinishScreen(),
  MainScreen.name: (context) => const MainScreen(),
  LoadingScreen.name: (context) => const LoadingScreen(),
  SettingScreen.name: (context) => const SettingScreen(),
};
