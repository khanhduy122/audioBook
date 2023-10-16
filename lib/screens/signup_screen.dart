import 'package:audio_book/components/app_asset.dart';
import 'package:audio_book/components/app_dialog.dart';
import 'package:audio_book/modules/auth/auth_bloc.dart';
import 'package:audio_book/modules/auth/auth_event.dart';
import 'package:audio_book/modules/auth/auth_exception.dart';
import 'package:audio_book/screens/send_email_comfirm_screen.dart';
import 'package:audio_book/widgets/button_widget_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/app_style.dart';
import '../widgets/button_widget_second.dart';
import '../widgets/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = "SignupScreen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthBloc _authBloc = AuthBloc();
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String comfirmPassword = "";

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: BlocListener(
          bloc: _authBloc,
          listenWhen: (previous, current) {
            return current is SignUpState;
          },
          listener: (context, state) {
            if (state is SignUpState) {
              if (state.isLoading == true) {
                AppDialog.showDialogLoading(context);
              }
              if (state.isSignUpSucces == true) {
                AppDialog.showToast("Successfully registered account", context);
                Navigator.pushReplacementNamed(
                    context, SendEmailComfirmScreen.name,
                    arguments: _email);
              }
              if (state.error != null) {
                Navigator.pop(context);
                if (state.error is EmailAlreadyInUse) {
                  AppDialog.showDialogNotify(
                      "This gmail is already registered", context);
                }
              }
            }
          },
          child: SafeArea(
              child: SizedBox(
            height: size.height,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: SizedBox(
                        height: size.height / 13,
                        width: size.width / 4,
                        child: Image.asset(
                          AppAsset.imgLogo,
                          fit: BoxFit.contain,
                        ))),
                Expanded(
                    flex: 9,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Register",
                            style: appStyle.titleTextStyle,
                          ),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFieldWidget(
                                    hintText: "Email",
                                    onChanged: (value) {
                                      _email = value;
                                    },
                                    validatorTextField: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter information";
                                      } else {
                                        if (!isEmailValid(value)) {
                                          return "Invalid email";
                                        }
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFieldWidget(
                                    hintText: "Password",
                                    obscureText: true,
                                    onChanged: (value) {
                                      _password = value;
                                    },
                                    validatorTextField: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter information";
                                      } else {
                                        if (value.length < 6) {
                                          return "Password must be greater than 6 characters";
                                        }
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFieldWidget(
                                    obscureText: true,
                                    hintText: "Comfirm Password",
                                    validatorTextField: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter information";
                                      } else {
                                        if (value != _password) {
                                          return "Passwords do not match";
                                        }
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "By signing up, you agree to our ",
                                style: appStyle.defaultTextStyle),
                            TextSpan(
                                text: "Terms, Data Policy ",
                                style: appStyle.textImportant),
                            TextSpan(
                                text: "and ", style: appStyle.defaultTextStyle),
                            TextSpan(
                                text: "Cookies Policy.",
                                style: appStyle.textImportant),
                          ])),
                          const SizedBox(
                            height: 20,
                          ),
                          ButtonPrimaryWidget(
                            title: "Register",
                            height: size.height / 14,
                            width: size.width,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _authBloc.add(SignUpWithEmailPasswordEvent(
                                    email: _email!,
                                    password: _password!,
                                    context: context));
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ButtonSecondWidget(
                            title: "Cancle",
                            height: size.height / 14,
                            width: size.width,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          )),
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }
}
