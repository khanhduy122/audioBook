import 'dart:async';
import 'package:audio_book/components/app_asset.dart';
import 'package:audio_book/components/app_dialog.dart';
import 'package:audio_book/components/app_key.dart';
import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/modules/auth/auth_bloc.dart';
import 'package:audio_book/modules/auth/auth_event.dart';
import 'package:audio_book/modules/auth/auth_exception.dart';
import 'package:audio_book/screens/forget_password_screen.dart';
import 'package:audio_book/screens/loading_screen.dart';
import 'package:audio_book/screens/send_email_comfirm_screen.dart';
import 'package:audio_book/screens/signup_screen.dart';
import 'package:audio_book/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/button_widget_primary.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  static const String name = "SignInScreen";

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isCheckRememberMe = false;
  late final AuthBloc authBloc;
  late final GlobalKey<FormState> _formKey;
  late final StreamController _errorAccountController;
  final TextEditingController _emailControler = TextEditingController();
  String? erroSignIn;
  String? _password;

  @override
  void initState() {
    authBloc = AuthBloc();
    _formKey = GlobalKey<FormState>();
    _errorAccountController = StreamController();
    getAccontRemember().then((value) {
      _emailControler.text = value;
      if(value.isNotEmpty){
        isCheckRememberMe = true;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _errorAccountController.close();
  }

  Future<void> setRememberAccount(String email) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(AppKey.rememberAccountkey, email);
  }

  Future<String> getAccontRemember() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString(AppKey.rememberAccountkey) != null){
      return sharedPreferences.getString(AppKey.rememberAccountkey)!;
    }else{
      return "";
    }
  }

  Future<void> removeRememberAccount() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(AppKey.rememberAccountkey);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size = MediaQuery.of(context).size;

    

    return Scaffold(
      body: BlocListener(
        bloc: authBloc,
        listenWhen: (previous, current) {
          return current is SignInState;
        },
        listener: (context, state) {
          if (state is SignInState) {
            if (state.isLoading == true) {
              AppDialog.showDialogLoading(context);
            }

            if (state.isSignInSucces != null && state.isSignInSucces == true) {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoadingScreen.name,
                (route) => false,
              );
              if(isCheckRememberMe){
                setRememberAccount(_emailControler.text);
              }else{
                removeRememberAccount();
              }
            }

            if (state.isVerificationEmail != null &&
                state.isVerificationEmail == false) {
              Navigator.pop(context);
              Navigator.pushNamed(context, SendEmailComfirmScreen.name,
                  arguments: _emailControler.text);
            }

            if (state.error != null) {
              Navigator.pop(context);
              if (state.error is InvalidLoginCredeniala) {
                erroSignIn = "Invalid Login Credeniala";
                _errorAccountController.sink.add(erroSignIn);
              }
              if (state.error is UserNotFound) {
                erroSignIn = "Invalid Login Credeniala";
                _errorAccountController.sink.add(erroSignIn);
              }
              if (state.error is WrongPassword) {
                erroSignIn = "Invalid Login Credeniala";
                _errorAccountController.sink.add(erroSignIn);
              }
            }
          }
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
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
                      flex: 6,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login to Your Account",
                              style: appStyle.titleTextStyle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            StreamBuilder(
                              stream: _errorAccountController.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data == null) {
                                    return Container();
                                  } else {
                                    return Center(
                                      child: Text(
                                        erroSignIn!,
                                        style: appStyle.textImportant,
                                      ),
                                    );
                                  }
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFieldWidget(
                                      controller: _emailControler,
                                      hintText: "Email",
                                      validatorTextField: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter account information";
                                        } else {
                                          if (!isEmailValid(value)) {
                                            return "Invalid email";
                                          }
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFieldWidget(
                                      hintText: "Password",
                                      obscureText: true,
                                      validatorTextField: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter account information";
                                        }
                                        return null;
                                      },
                                      onChanged: (passsword) {
                                        _password = passsword;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )),
                            Row(
                              children: [
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return Checkbox(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      checkColor: themeData.primaryColor,
                                      value: isCheckRememberMe,
                                      onChanged: (value) {
                                        isCheckRememberMe = value!;
                                        setState(() {});
                                      },
                                    );
                                  },
                                ),
                                Text(
                                  "Remember me",
                                  style: appStyle.defaultTextStyle,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ButtonPrimaryWidget(
                              title: "Sig In",
                              height: size.height / 15,
                              width: size.width,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  authBloc.add(SignInWithEmailPasswordEvent(
                                      email: _emailControler.text, password: _password!));
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ForgetPasswordScreen.name);
                              },
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "Forget Password ?",
                                  style: appStyle.textImportant,
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Or Sigin with",
                            style: appStyle.defaultTextStyle,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _itemSignIn(
                                size: size,
                                image: AppAsset.icGoogle,
                                onTap: () {
                                  //signinGoogle();
                                  authBloc.add(SignInWithGoogle());
                                },
                              ),
                              _itemSignIn(
                                size: size,
                                image: AppAsset.icFacebook,
                                onTap: () {},
                              ),
                              _itemSignIn(
                                size: size,
                                image: AppAsset.icTwitter,
                                onTap: () {},
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don’t have an accoun’t ? ",
                                style: appStyle.defaultTextStyle,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, SignUpScreen.name);
                                },
                                child: Text(
                                  "Register",
                                  style: appStyle.textImportant,
                                ),
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  Widget _itemSignIn(
      {required Size size, required String image, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height / 14,
        width: size.width / 4,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.onSurface),
            borderRadius: BorderRadius.circular(8)),
        child: Image.asset(
          image,
          fit: BoxFit.scaleDown,
          height: size.height / 16,
          width: size.width / 5,
        ),
      ),
    );
  }

}