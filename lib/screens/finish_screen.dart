import 'package:audio_book/widgets/button_widget_primary.dart';
import 'package:flutter/material.dart';

import '../components/app_asset.dart';
import '../components/app_style.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  static const String name = "FinishScreen";

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
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
              flex: 3,
              child: Image.asset(
                AppAsset.imgFinishScreen,
                fit: BoxFit.contain,
              )),
          Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "You are ready to go!",
                      style: appStyle.titleTextStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Congratulation, any interesting topics will be shortly in your hands.",
                      textAlign: TextAlign.center,
                      style: appStyle.defaultTextStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonPrimaryWidget(
                      title: "Finish",
                      height: size.height / 14,
                      width: size.width,
                      onTap: () {},
                    )
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
