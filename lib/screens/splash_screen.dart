import 'package:audio_book/components/app_asset.dart';
import 'package:audio_book/components/app_key.dart';
import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/models/data_provider.dart';
import 'package:audio_book/modules/firebase/firebase_bloc.dart';
import 'package:audio_book/modules/firebase/firebase_event.dart';
import 'package:audio_book/screens/main_screen.dart';
import 'package:audio_book/screens/signin_screen.dart';
import 'package:audio_book/screens/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = "SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final FirebaseBloc getDataAppBloc = FirebaseBloc();

 @override
  Widget build(BuildContext context) {
    final AppStyle appStyle = AppStyle(themeData: Theme.of(context));
    final Size size = MediaQuery.of(context).size;

    navigationSlashScreen(context);

    return BlocListener(
      bloc: getDataAppBloc ,
      listener: (context, state) {
        if(state is DataAppState){
          if(state.trendingNow != null){
            context.read<DataProvider>().initData(recommend: state.recommend!, bestSeller: state.bestSeller!, 
            newRelease: state.newRelease!, trendingNow: state.trendingNow!, allAudioBook: state.allAudioBook!);
            Navigator.pushNamedAndRemoveUntil(context, MainScreen.name, (route) => false);
          }
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  height: size.height / 6,
                  width: size.width / 3,
                  child: Image.asset(
                    AppAsset.imgLogo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: (size.height / 8)),
              child: Text(
                "Version 1.0",
                style: appStyle.titleTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> navigationSlashScreen(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified == false) {
      FirebaseAuth.instance.signOut();
      Future.delayed(
        const Duration(seconds: 3),
        () {
          Navigator.pushNamedAndRemoveUntil(
              context, SigninScreen.name, (route) => false);
        },
      );
    } else {
      if (FirebaseAuth.instance.currentUser != null) {
        getDataAppBloc.add(GetDataAppEvent());
      } else {
        if (sharedPreferences.getBool(AppKey.checkBeginer) == null) {
          Future.delayed(
            const Duration(seconds: 3), () {
              sharedPreferences.setBool(AppKey.checkBeginer, true);
              Navigator.pushNamedAndRemoveUntil(
                  context, OnBoardingScreen.name, (route) => false);
            },
          );
        } else {
          Future.delayed(
            const Duration(seconds: 3), () {
              Navigator.pushNamedAndRemoveUntil(
                  context, SigninScreen.name, (route) => false);
            },
          );
        }
      }
    }
  }
}


