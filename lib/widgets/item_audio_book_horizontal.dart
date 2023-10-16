import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/models/audio_book.dart';
import 'package:audio_book/widgets/image_network_widget.dart';
import 'package:flutter/material.dart';

class ItemAudioBookHorizontal extends StatelessWidget {
  const ItemAudioBookHorizontal({super.key, required this.audioBook, required this.height, required this.width, required this.onTap});

  final AudioBook audioBook;
  final double height;
  final double width;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ImageNetworkWidget(imageUrl: audioBook.thumbnail!)),
            const SizedBox(height: 10,),
            Text(audioBook.title!,
              style: AppStyle(themeData: Theme.of(context)).titleTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
            Text(audioBook.writer!,
              style: AppStyle(themeData: Theme.of(context)).defaultTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}