import 'package:audio_book/components/app_asset.dart';
import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/models/audio_book.dart';
import 'package:audio_book/screens/play_audio_book_screen.dart';
import 'package:audio_book/widgets/button_widget_primary.dart';
import 'package:audio_book/widgets/button_widget_second.dart';
import 'package:audio_book/widgets/image_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AudioBookDetailScreen extends StatefulWidget {
  const AudioBookDetailScreen({super.key, required this.audioBook});

  final AudioBook audioBook;

  @override
  State<AudioBookDetailScreen> createState() => _AudioBookDetailScreenState();
}

class _AudioBookDetailScreenState extends State<AudioBookDetailScreen> {


  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    final AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        automaticallyImplyLeading: true,
        title: Text(
          widget.audioBook.title!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: appStyle.titleTextStyle,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Center(
                child: SizedBox(
                  height: size.height / 2.5,
                  width: size.width / 1.5,
                  child: ImageNetworkWidget(imageUrl: widget.audioBook.thumbnail!),
                ),
              ),
              const SizedBox(height: 20,),
              Text(
                widget.audioBook.title!,
                style: appStyle.titleTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10,),
              Text(
                widget.audioBook.writer!,
                style: appStyle.defaultTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: double.parse(widget.audioBook.rating!),
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemSize: 20,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) {
                      
                    },
                  ),

                  Text(widget.audioBook.rating!.toString(),
                    style: appStyle.defaultTextStyle,
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Wrap(
                direction: Axis.horizontal,
                children: [
                  _itemCategory("Fantasy"),
                  _itemCategory("Drama"),
                  _itemCategory("Fiction"),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonPrimaryWidget(
                    title: "Play Audio", 
                    iconAssets: AppAsset.icPlayCategory,
                    height: size.height / 14, 
                    width: size.width/2.5, 
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PlayAudioBookScreen(audioBook: widget.audioBook),));
                    },
                  ),
                  ButtonSecondWidget(
                    title: "Read Book", 
                    iconAssets: AppAsset.icLibrary,
                    height: size.height / 14, 
                    width: size.width/2.5, 
                    onTap: () {
                      
                    },
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Text(
                "Summary",
                style: appStyle.titleTextStyle,
              ),
              const SizedBox(height: 20,),
              Text(
                widget.audioBook.summary!,
                style: appStyle.defaultTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemCategory(String title){
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
        title,
        style: AppStyle(themeData: Theme.of(context)).defaultTextStyle,
      ),
    );
  }

  
}