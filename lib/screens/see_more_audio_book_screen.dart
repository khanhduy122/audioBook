import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/models/audio_book.dart';
import 'package:audio_book/screens/audio_book_detail.dart';
import 'package:audio_book/widgets/item_audio_book.dart';
import 'package:flutter/material.dart';

class SeeMoreAudioBookScreen extends StatelessWidget {
  const SeeMoreAudioBookScreen({super.key, required this.title, required this.listAudioBook});

  final String title;
  final List<AudioBook> listAudioBook;

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(title, style: AppStyle(themeData: Theme.of(context)).titleTextStyle,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: SizedBox(
            height: listAudioBook.length % 2 == 0 ? (size.height / 3) * listAudioBook.length : (size.height / 3) * listAudioBook.length + 1,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10
              ), 
              itemCount: listAudioBook.length, 
              itemBuilder: (context, index) {
                return ItemAudioBook(
                  height: size.height / 2.5,
                  width: size.width / 2.5,
                  audioBook: listAudioBook[index],
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AudioBookDetailScreen(audioBook: listAudioBook[index]),));
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}