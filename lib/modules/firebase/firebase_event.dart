import 'package:audio_book/models/audio_book.dart';
import 'package:flutter/material.dart';

abstract class FirebaseEvent{}

class GetDataAppEvent extends FirebaseEvent{}

class AddAudioBookLateSearchEvent extends FirebaseEvent{
  final AudioBook audioBook;

  AddAudioBookLateSearchEvent({required this.audioBook});
}

class UpdateUserProfileEvent extends FirebaseEvent{
  String? displayName;

  UpdateUserProfileEvent({this.displayName});
}
