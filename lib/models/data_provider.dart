
import 'package:audio_book/models/audio_book.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier{
  late final List<AudioBook> recommend;
  late final List<AudioBook> bestSeller;
  late final List<AudioBook> newRelease;
  late final List<AudioBook> trendingNow;
  late final List<AudioBook> allAudioBook;

  DataProvider();

  void initData({required List<AudioBook> recommend, required List<AudioBook> bestSeller, 
  required List<AudioBook> newRelease, required List<AudioBook> trendingNow, required List<AudioBook> allAudioBook}){
    this.recommend = recommend;
    this.bestSeller = bestSeller;
    this.newRelease = newRelease;
    this.trendingNow = trendingNow;
    this.allAudioBook = allAudioBook;
  }

}