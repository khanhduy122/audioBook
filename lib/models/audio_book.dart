
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class AudioBook{
  String? title;
  String? writer;
  String? summary;
  String? thumbnail;
  String? timestamp;
  String? rating;
  

  //factory AudioBook.fromJson(Map<String, dynamic> json) => _$AudioBookFromJson(json);

  AudioBook.fromJson(Map<String, dynamic> json) {
    title =json['title'];
    writer = json['writer'];
    thumbnail = json['thumbnail'];
    timestamp = json['timestamp'];
    summary = json['summary'];
    rating = json['rating'];
  }

  
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'writer': writer,
      'thumbnail': thumbnail,
      'timestamp': timestamp,
      'summary' : summary,
      'rating' : rating,
    };
  }

}