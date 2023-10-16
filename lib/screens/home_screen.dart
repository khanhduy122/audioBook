import 'package:audio_book/components/app_asset.dart';
import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/models/audio_book.dart';
import 'package:audio_book/models/data_provider.dart';
import 'package:audio_book/screens/audio_book_detail.dart';
import 'package:audio_book/screens/see_more_audio_book_screen.dart';
import 'package:audio_book/screens/setting_screen.dart';
import 'package:audio_book/widgets/image_network_widget.dart';
import 'package:audio_book/widgets/item_audio_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String name = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = ["Art", "Business", "Biography", "Comedy", "Culture", "Education"];
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: appStyle.titleTextStyle,
                    ),
                    Text(
                      "See more",
                      style: appStyle.defaultTextStyle.copyWith(color: themeData.colorScheme.primary),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: themeData.colorScheme.onSurface,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                          categories[index],
                          style: appStyle.defaultTextStyle,
                        ),
                      );
                    },
                  ),
                ),
          
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommended For You",
                      style: appStyle.titleTextStyle,
                    ),
                    Text(
                      "See more",
                      style: appStyle.defaultTextStyle.copyWith(color: themeData.colorScheme.primary),
                    )
                  ],
                ),
          
                const SizedBox(height: 20,),
                SizedBox(
                  height: size.height/2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: context.read<DataProvider>().recommend.length,
                    itemBuilder: (context, index) {
                      return recommendItem(context.read<DataProvider>().recommend[index].thumbnail!, size);
                    },
                  ),
                ),

                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Best Seller",
                      style: appStyle.titleTextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => 
                        SeeMoreAudioBookScreen(title: "Best Seller", listAudioBook: context.read<DataProvider>().bestSeller),));
                      },
                      child: Text(
                        "See more",
                        style: appStyle.defaultTextStyle.copyWith(color: themeData.colorScheme.primary),
                      ),
                    )
                  ],
                ),
        
                const SizedBox(height: 20,),
                SizedBox(
                  height: size.height/5,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: context.read<DataProvider>().bestSeller.length,
                    itemBuilder: (context, index) {
                      return bestSeller(context.read<DataProvider>().bestSeller[index], size, themeData);
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Releases",
                      style: appStyle.titleTextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => 
                        SeeMoreAudioBookScreen(title: "New Releases", listAudioBook: context.read<DataProvider>().newRelease),));
                      },
                      child: Text(
                        "See more",
                        style: appStyle.defaultTextStyle.copyWith(color: themeData.colorScheme.primary),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: size.height/3.5,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: context.read<DataProvider>().newRelease.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: ItemAudioBook(
                          audioBook: context.read<DataProvider>().newRelease[index],
                          height: size.height/3.5,
                          width: size.width / 2,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AudioBookDetailScreen(audioBook: context.read<DataProvider>().newRelease[index]),));
                          },
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trending Now",
                      style: appStyle.titleTextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => 
                        SeeMoreAudioBookScreen(title: "Trading Now", listAudioBook: context.read<DataProvider>().trendingNow),));
                      },
                      child: Text(
                        "See More",
                        style: appStyle.defaultTextStyle.copyWith(color: themeData.colorScheme.primary),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 20,),
                SizedBox(
                  height: size.height/3.5,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: context.read<DataProvider>().trendingNow.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: ItemAudioBook(
                          audioBook: context.read<DataProvider>().trendingNow[index],
                          height: size.height/3.5,
                          width: size.width / 2,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AudioBookDetailScreen(audioBook: context.read<DataProvider>().trendingNow[index]),));
                          },
                        ),
                      );
                    },
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget recommendItem(String imageURL, Size size){
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ImageNetworkWidget(
        imageUrl: imageURL, 
        height: size.height/2,
        width: size.width * 2/3,
      )
    );
  }

  Widget bestSeller(AudioBook audioBook, Size size, ThemeData themeData){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AudioBookDetailScreen(audioBook: audioBook),));
      },
      child: Container(
        height: size.height / 5,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: themeData.colorScheme.onSurface,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            ImageNetworkWidget(
              imageUrl: audioBook.thumbnail!, 
              height: size.height / 5, 
              width: size.width / 3
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(audioBook.title!,
                    style: AppStyle(themeData: themeData).titleTextStyle,
                  ),
                  Text(audioBook.writer!,
                    style: AppStyle(themeData: themeData).defaultTextStyle,
                  ),
                  Row(
                children: [
                  RatingBar.builder(
                    initialRating: double.parse(audioBook.rating!),
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemSize: 20,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) {
                      
                    },
                  ),

                  Text(audioBook.rating!.toString(),
                    style: AppStyle(themeData: themeData).defaultTextStyle,
                  )
                ],
              ),
                  Text("1,000+ Listeners",
                    style: AppStyle(themeData: themeData).defaultTextStyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
