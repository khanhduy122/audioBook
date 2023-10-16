
import 'package:audio_book/models/audio_book.dart';
import 'package:audio_book/modules/firebase/firebase_event.dart';
import 'package:audio_book/modules/firebase/firebase_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState>{
  

  FirebaseBloc() : super(FirebaseState()){
    on<GetDataAppEvent>((event, emit) => _getDataAppBloc(emit));

    on<AddAudioBookLateSearchEvent>((event, emit) => _addAudioBookLateSearchEvent(event),);

    on<UpdateUserProfileEvent>((event, emit) => _updateUserProfileEvent(event, emit) );
  }
  

  void _getDataAppBloc(Emitter<FirebaseState> emit) async {
     final List<AudioBook> recommend = await FirebaseRepo.getHomeRecoment();
     final List<AudioBook> bestSeller = await FirebaseRepo.getHomeBestSeller();
     final List<AudioBook> newRelease = await FirebaseRepo.getHomeNewReleases();
     final List<AudioBook> trendingNow = await FirebaseRepo.getHomeTrendingNow();
     final List<AudioBook> allAudioBook = await FirebaseRepo.getAllAudioBook();
     emit(DataAppState(recommend: recommend, bestSeller: bestSeller, newRelease: newRelease, trendingNow: trendingNow, allAudioBook: allAudioBook ));
  }

  void _addAudioBookLateSearchEvent(AddAudioBookLateSearchEvent event){
    FirebaseRepo.addAudioBooLastSearch(event.audioBook);
  }

  void _updateUserProfileEvent(UpdateUserProfileEvent event, Emitter<FirebaseState> emit) async{
    if(event.displayName != null){
      emit(UserState(isLoading: true));
      await FirebaseAuth.instance.currentUser!.updateDisplayName(event.displayName);
      emit(UserState(user: FirebaseAuth.instance.currentUser!));
    }
  }
}

class FirebaseState{}

class DataAppState extends FirebaseState{
  List<AudioBook>? recommend;
  List<AudioBook>? bestSeller;
  List<AudioBook>? newRelease;
  List<AudioBook>? trendingNow;
  List<AudioBook>? allAudioBook;
  List<AudioBook>? audioBookLateSearch;

  DataAppState({this.bestSeller, this.newRelease, this.recommend, this.trendingNow, this.audioBookLateSearch, this.allAudioBook});
}

class UserState extends FirebaseState{
  bool? isLoading;
  User? user;
  UserState({this.user, this.isLoading});
}