import 'package:audio_book/components/app_asset.dart';
import 'package:audio_book/models/audio_book.dart';
import 'package:audio_book/widgets/image_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/app_style.dart';

class PlayAudioBookScreen extends StatefulWidget {
  const PlayAudioBookScreen({super.key, required this.audioBook});

  final AudioBook audioBook;

  @override
  State<PlayAudioBookScreen> createState() => _PlayAudioBookScreenState();
}

class _PlayAudioBookScreenState extends State<PlayAudioBookScreen> {
  @override
  Widget build(BuildContext context) {
    
    final ThemeData themeData = Theme.of(context);
    final AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(widget.audioBook.title!,
          style: appStyle.titleTextStyle,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height / 2.5,
              child: ImageNetworkWidget(imageUrl: widget.audioBook.thumbnail!, radius: 20,),
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
            Slider(
              max: 100,
              min: 0,
              value: 0, 
              onChanged: (value) {
                
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("00:00",
                  style: appStyle.defaultTextStyle,
                ),
                Text("04:52",
                  style: appStyle.defaultTextStyle,
                )
              ],
            ),
            const SizedBox(height: 20,),
            _controllerAudioBook(),
             const SizedBox(height: 20,),
            _bottmBarPlayAudio()
          ],
        ),
      ),
    );
  }

  Widget _controllerAudioBook(){
    bool isPlay = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 20.h,
          width: 20.w,
          child: Image.asset(AppAsset.icVolume, fit: BoxFit.contain,),
        ),
        SizedBox(
          height: 35.h,
          width: 35.w,
          child: Image.asset(AppAsset.icArrowLeft, fit: BoxFit.contain),
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  isPlay = !isPlay;
                },);
              },
              child: Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                  borderRadius: BorderRadius.circular(30.h)
                ),
                child: Image.asset(
                  isPlay == true ? AppAsset.icPause : AppAsset.icPlay,
                  fit: BoxFit.scaleDown,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            );
          },
        ),
        
        SizedBox(
          height: 35.h,
          width: 35.w,
          child: Image.asset(AppAsset.icArrowRight, fit: BoxFit.contain),
        ),
        SizedBox(
          height: 20.h,
          width: 20.w,
          child: Image.asset(AppAsset.icUpload, fit: BoxFit.contain),
        ),
      ],
    );
  }

  Widget _bottmBarPlayAudio(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(AppAsset.icBookMark, color: Theme.of(context).colorScheme.onPrimary, fit: BoxFit.scaleDown,)
              ),
              Text("BookMark",
                style: AppStyle(themeData: Theme.of(context)).defaultTextStyle.copyWith(fontSize: 10),
              )
            ],
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(AppAsset.icPaper, color: Theme.of(context).colorScheme.onPrimary, fit: BoxFit.scaleDown,)
              ),
              Text("Chapter 2",
                style: AppStyle(themeData: Theme.of(context)).defaultTextStyle.copyWith(fontSize: 10),
              )
            ],
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(AppAsset.icClock, color: Theme.of(context).colorScheme.onPrimary, fit: BoxFit.scaleDown,)
              ),
              Text("Speed 10x",
                style: AppStyle(themeData: Theme.of(context)).defaultTextStyle.copyWith(fontSize: 10),
              )
            ],
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(AppAsset.icDowLoad, color: Theme.of(context).colorScheme.onPrimary, fit: BoxFit.scaleDown,)
              ),
              Text("Dowload",
                style: AppStyle(themeData: Theme.of(context)).defaultTextStyle.copyWith(fontSize: 10),
              )
            ],
          ),
        ),
      ],
    );
  }
}