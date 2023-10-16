import 'dart:async';

import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/models/audio_book.dart';
import 'package:audio_book/models/data_provider.dart';
import 'package:audio_book/modules/firebase/firebase_bloc.dart';
import 'package:audio_book/modules/firebase/firebase_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/app_asset.dart';
import '../widgets/item_audio_book.dart';
import '../widgets/text_field_widget.dart';
import 'audio_book_detail.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key, required this.searchContent});

  final String searchContent;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {

   final TextEditingController _textSearrchController = TextEditingController();
   final StreamController<bool> _searchStreamController = StreamController<bool>();
   final List<AudioBook> searchResult = [];
   final FirebaseBloc firebaseBloc = FirebaseBloc();

   @override
  void initState() {
    super.initState();
    searchAudioBook(widget.searchContent);
  }

   @override
  void dispose() {
    super.dispose();
    _textSearrchController.dispose();
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
            
                    SizedBox(
                      height: 50,
                      child: Image.asset(AppAsset.icSetting, color: themeData.colorScheme.primaryContainer,)
                    ),
                  ],
                ),
              const SizedBox(height: 40,),
              TextFieldWidget(
                controller: _textSearrchController,
                hintText: "Search Books or Author...",
                onFieldSubmitted: (value) {
                  searchAudioBook(value);
                },
              ),
              const SizedBox(height: 20,),
              Text(
                "Search Result",
                style: appStyle.titleTextStyle,
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: StreamBuilder(
                  stream: _searchStreamController.stream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      if(snapshot.data!){
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount (
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10
                          ),
                          itemCount: searchResult.length, 
                          itemBuilder: (context, index) {
                            return ItemAudioBook(
                              height: size.height / 3 ,
                              width: size.width / 2.5,
                              audioBook: searchResult[index],
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AudioBookDetailScreen(audioBook: searchResult[index]),));
                                firebaseBloc.add(AddAudioBookLateSearchEvent(audioBook: searchResult[index]));
                              },
                            );
                          },
                        );
                      }else{
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }else{
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void searchAudioBook(String searchContent){
    _searchStreamController.sink.add(false);
    searchResult.clear();
    _textSearrchController.text = searchContent;
    context.read<DataProvider>().allAudioBook.forEach((element) {
      if(element.title!.toLowerCase().contains(searchContent.toLowerCase())){
        searchResult.add(element);
      }
     });
     _searchStreamController.sink.add(true);
  }
}