import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/modules/firebase/firebase_bloc.dart';
import 'package:audio_book/screens/setting_screen.dart';
import 'package:audio_book/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/app_asset.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    final AppStyle appStyle = AppStyle(themeData: themeData);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 50,
                                child: Image.asset(AppAsset.imgLogo, color: themeData.colorScheme.primaryContainer)
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: "Audio",
                                      style: TextStyle(color: themeData.colorScheme.primaryContainer, fontSize: 24, fontWeight: FontWeight.w700)
                                    ),
                                    TextSpan(
                                      text: "Book",
                                      style: TextStyle(color: themeData.colorScheme.primaryContainer, fontSize: 24,)
                                    )
                                  ]
                                )
                              )
                            ],
                          ),
                  
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen(),));
                            },
                            child: SizedBox(
                              height: 50,
                              child: Image.asset(AppAsset.icSetting, color: themeData.colorScheme.primaryContainer,)
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 40,),
                    TextFieldWidget(
                      hintText: "Search Books or Author...",
                      
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      "My Books",
                      style: appStyle.titleTextStyle,
                    ),
                    const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
