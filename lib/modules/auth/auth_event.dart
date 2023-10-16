import 'package:flutter/material.dart';

abstract class AuthEvent{}

class SignInWithEmailPasswordEvent extends AuthEvent{
  final String email;
  final String password;

  SignInWithEmailPasswordEvent({required this.email, required this.password});
}

class SignUpWithEmailPasswordEvent extends AuthEvent{
  final String email;
  final String password;
  final BuildContext context;

  SignUpWithEmailPasswordEvent({required this.email, required this.password, required this.context});
}

class SignInWithGoogle extends AuthEvent{}

class CheckVerificationEmailEvent extends AuthEvent{}

class SignOutEvent extends AuthEvent{}