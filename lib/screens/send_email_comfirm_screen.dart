import 'dart:async';

import 'package:audio_book/modules/auth/auth_bloc.dart';
import 'package:audio_book/modules/auth/auth_event.dart';
import 'package:audio_book/screens/signin_screen.dart';
import 'package:audio_book/screens/welcom_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/app_asset.dart';
import '../components/app_style.dart';
import '../widgets/button_widget_second.dart';

class SendEmailComfirmScreen extends StatefulWidget {
  const SendEmailComfirmScreen({super.key});

  static const String name = "SendEmailComfirmScreen";

  @override
  State<SendEmailComfirmScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SendEmailComfirmScreen> {

  late final Timer _timer;
  bool isVerificationEmail = false;
  late final AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = AuthBloc();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        authBloc.add(CheckVerificationEmailEvent());
     });
  }

  @override
  void dispose() {
    super.dispose();
    if(!mounted){
      _timer.cancel();
      if(FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified == false){
        FirebaseAuth.instance.signOut();
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final String _email = ModalRoute.of(context)!.settings.arguments as String;
    final String emailType = _email.split('@')[1];
    ThemeData themeData = Theme.of(context);
    AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener(
        bloc: authBloc,
        listener: (context, state) {
          if(state is SignInState){
            if(state.isVerificationEmail != null && state.isVerificationEmail == true){
              Navigator.pushNamedAndRemoveUntil(context, WelcomScreen.name, (route) => false,);
            }
          }
        },
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: size.height/13,
                width: size.width/4,
                child: Image.asset(AppAsset.imgLogo, fit: BoxFit.contain,)
              )
            ),
            
            Expanded(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Text(
                        "Email Sent",
                        style: appStyle.titleTextStyle,
                      ),
              
                      const SizedBox(height: 20,),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "We sent an email to ",
                              style: appStyle.defaultTextStyle
                            ),
                            TextSpan(
                              text: _email.characters.first,
                              style: appStyle.textImportant
                            ),
                            TextSpan(
                              text: "***",
                              style: appStyle.textImportant
                            ),
                            TextSpan(
                              text: emailType,
                              style: appStyle.textImportant
                            ),
                            TextSpan(
                              text: " with a link to get back into your account.",
                              style: appStyle.defaultTextStyle
                            ),
                          ]
                        )
                      ),
              
                      const SizedBox(height: 20,),
                      ButtonSecondWidget(
                          title: "close", 
                          height: size.height / 14, 
                          width: size.width, 
                          onTap: () {
                            Navigator.popUntil(context, (route) => route.settings.name == SigninScreen.name,);
                          },
                        ),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}