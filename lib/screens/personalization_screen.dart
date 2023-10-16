import 'dart:async';

import 'package:audio_book/components/app_asset.dart';
import 'package:audio_book/screens/finish_screen.dart';
import 'package:audio_book/screens/home_screen.dart';
import 'package:audio_book/widgets/button_widget_second.dart';
import 'package:audio_book/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../components/app_style.dart';

class PersonalizationScreen extends StatefulWidget {
  const PersonalizationScreen({super.key});

  static const String name = "PersonalizationScreen";

  @override
  State<PersonalizationScreen> createState() => _PersonalizationScreenState();
}

class _PersonalizationScreenState extends State<PersonalizationScreen> {
  int count = 0;
  final StreamController _controllerSubmit = StreamController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerSubmit.close();
  }

  @override
  Widget build(BuildContext context) {
    count = 0;
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
                    "Personalize Suggestion",
                    style: appStyle.titleTextStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Choose min. 3 topic you like, we will give you more often that relate to it.",
                    style: appStyle.defaultTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextFieldWidget(
                    hintText: "Search Categories",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(children: [
                    itemSuggestion("Art", context),
                    itemSuggestion("Business", context),
                    itemSuggestion("Biography", context),
                    itemSuggestion("Comedy", context),
                    itemSuggestion("Culture", context),
                    itemSuggestion("Education", context),
                    itemSuggestion("News", context),
                    itemSuggestion("Philosophy", context),
                    itemSuggestion("Psychology", context),
                    itemSuggestion("Technology", context),
                    itemSuggestion("Travel", context),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                      stream: _controllerSubmit.stream,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(size.width, size.height / 14),
                                backgroundColor: count >= 3
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            onPressed: () {
                              if (count >= 3) {
                                Navigator.pushNamed(context, FinishScreen.name);
                              }
                            },
                            child: Text(
                              "Submit",
                              style: AppStyle(themeData: Theme.of(context))
                                  .textButtonPrimary,
                            ));
                      }),
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

  Widget itemSuggestion(String title, BuildContext context) {
    bool isChecked = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: () {
            if (isChecked) {
              count--;
              _controllerSubmit.sink.add(count);
              setState(() {
                isChecked = false;
              });
            } else {
              count++;
              _controllerSubmit.sink.add(count);
              setState(() {
                isChecked = true;
              });
            }
          },
          child: Container(
            margin: const EdgeInsets.only(right: 5, top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: isChecked == true
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isChecked == true
                      ? Theme.of(context).colorScheme.background
                      : Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        );
      },
    );
  }
}
