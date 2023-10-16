import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/models/audio_book.dart';
import 'package:audio_book/modules/firebase/firebase_repo.dart';
import 'package:audio_book/screens/search_result_screen.dart';
import 'package:audio_book/screens/setting_screen.dart';
import 'package:audio_book/widgets/item_audio_book.dart';
import 'package:audio_book/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../components/app_asset.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


   @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    final AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                  onFieldSubmitted: (value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResultScreen(searchContent: value),));
                  },
                ),
                const SizedBox(height: 20,),
                Text(
                  "Recommended Categories",
                  style: appStyle.titleTextStyle,
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: size.width,
                  child: Wrap(
                    runSpacing: 10,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      itemRecommendedCategories("Business", AppAsset.icBusiness),
                      itemRecommendedCategories("Personal", AppAsset.icProfile),
                      itemRecommendedCategories("Music", AppAsset.icPlayCategory),
                      itemRecommendedCategories("Photograp", AppAsset.icCamera)
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Text(
                  "Latest Search",
                  style: appStyle.titleTextStyle,
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: size.height / 3.5,
                  child: StreamBuilder(
                    stream: FirebaseRepo.getAllAudioBooLastSearch1(),
                    builder: (context, snapshot) {
                      
                      if(snapshot.hasData){
                        final listAudioBookSearch = snapshot.data!.docs.map((e) => AudioBook.fromJson(e.data())).toList() ?? [];
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listAudioBookSearch.length,
                            itemBuilder: (context, index) {
                            return ItemAudioBook(
                              audioBook: listAudioBookSearch[index], 
                              height: size.height / 3.5, 
                              width: size.width / 2,
                              onTap: () {
                                
                              },
                            );
                          },
                        );
                      }else{
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget itemRecommendedCategories(String title, String iconAssets, ){
    return Container(
      height: MediaQuery.of(context).size.height / 16,
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(iconAssets, fit: BoxFit.contain,),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(title,
              style: AppStyle(themeData: Theme.of(context)).defaultTextStyle,
            ),
          )
        ],
      ),
    );
  }
}