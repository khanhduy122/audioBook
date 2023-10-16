import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/screens/home_screen.dart';
import 'package:audio_book/screens/personalization_screen.dart';
import 'package:audio_book/widgets/button_widget_primary.dart';
import 'package:audio_book/widgets/button_widget_second.dart';
import 'package:flutter/material.dart';

import '../components/app_asset.dart';

class WelcomScreen extends StatefulWidget {
  const WelcomScreen({super.key});

  static const String name = "WelcomScreen";

  @override
  State<WelcomScreen> createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    AppAsset.imgBackgroud1,
                    fit: BoxFit.contain,
                  )),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    AppAsset.imgBackgroud2,
                    fit: BoxFit.contain,
                  ))
            ],
          ),
        ),
        Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome !",
                    style: appStyle.textImportant,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Find what \nyou are \nlooking for",
                    style: TextStyle(
                        color: themeData.colorScheme.onPrimary,
                        fontSize: 48,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      "By personalize your account, we can help you to find what you like.",
                      style: appStyle.defaultTextStyle
                          .copyWith(fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonPrimaryWidget(
                    title: "Personalize Your Account",
                    height: size.height / 14,
                    width: size.width,
                    onTap: () {
                      Navigator.pushNamed(context, PersonalizationScreen.name);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonSecondWidget(
                    title: "Skip",
                    height: size.height / 14,
                    width: size.width,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.name, (route) => false);
                    },
                  )
                ],
              ),
            ))
      ]),
    ));
  }
}
