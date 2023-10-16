
import 'package:audio_book/models/audio_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepo{

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<AudioBook>> getHomeRecoment() async {
    List<AudioBook> listRecomend = [];
    try {
      final respone = await _firestore.collection("AudioBook").doc("Home").collection("Recommended").get();
      respone.docs.forEach((element) {
        listRecomend.add(AudioBook.fromJson(element.data()));
      });
    } catch (e) {
      throw Exception(e);
    }
    return listRecomend;
  }

  static Future<List<AudioBook>> getHomeBestSeller() async {
    List<AudioBook> listBestSeller = [];
    try {
      await _firestore.collection("AudioBook").doc("Home").collection("BestSeller").get().then((QuerySnapshot value) {
        for (QueryDocumentSnapshot document in value.docs){
          AudioBook audioBook = AudioBook.fromJson(document.data() as Map<String, dynamic>);
          print(audioBook.title);
          listBestSeller.add(audioBook);
        }
      });
    } catch (e) {
      throw Exception(e);
    }
    return listBestSeller;
  } 

  static Future<List<AudioBook>> getHomeNewReleases() async {
    List<AudioBook> listNewReleases = [];
    try {
      await _firestore.collection("AudioBook").doc("Home").collection("NewReleases").get().then((QuerySnapshot value) {
        for (QueryDocumentSnapshot document in value.docs){
          AudioBook audioBook = AudioBook.fromJson(document.data() as Map<String, dynamic>);
          listNewReleases.add(audioBook);
        }
      });
    } catch (e) {
      throw Exception(e);
    }
    return listNewReleases;
  } 

  static Future<List<AudioBook>> getHomeTrendingNow() async {
    List<AudioBook> listTrendingNow = [];
    try {
      await _firestore.collection("AudioBook").doc("Home").collection("TrendingNow").get().then((QuerySnapshot value) {
        for (QueryDocumentSnapshot document in value.docs){
          AudioBook audioBook = AudioBook.fromJson(document.data() as Map<String, dynamic>);
          listTrendingNow.add(audioBook);
        }
      });
    } catch (e) {
      throw Exception(e);
    }
    return listTrendingNow;
  } 

  static Future<void> addAudioBooLastSearch(AudioBook audioBook) async {
    audioBook.timestamp = DateTime.now().microsecondsSinceEpoch.toString();
    await _firestore.collection("User").doc(FirebaseAuth.instance.currentUser!.uid).collection("Last Search").doc(audioBook.title).get().then((value) async {
      if(value.exists){
        await _firestore.collection("User").doc(FirebaseAuth.instance.currentUser!.uid).collection("Last Search").doc(audioBook.title).delete();
        await _firestore.collection("User").doc(FirebaseAuth.instance.currentUser!.uid).collection("Last Search").doc(audioBook.title).set(audioBook.toJson());
      }else{
        await _firestore.collection("User").doc(FirebaseAuth.instance.currentUser!.uid).collection("Last Search").doc(audioBook.title).set(audioBook.toJson());
      }
    });
  }  

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllAudioBooLastSearch1() {
    return _firestore.collection("User").doc(FirebaseAuth.instance.currentUser!.uid).collection("Last Search").orderBy("timestamp", descending: true).snapshots();
  }  

  static Future<List<AudioBook>> getAllAudioBooLastSearch() async {
    List<AudioBook> listAudioBookLastSearch = [];
    try {
      await _firestore.collection("User").doc(FirebaseAuth.instance.currentUser!.uid).collection("Last Search").get().then((QuerySnapshot value) {
        for (QueryDocumentSnapshot document in value.docs){
          AudioBook audioBook = AudioBook.fromJson(document.data() as Map<String, dynamic>);
          listAudioBookLastSearch.add(audioBook);
        }
      });
    } catch (e) {
      throw Exception(e);
    }
    return listAudioBookLastSearch;
  }  

  static Future<List<AudioBook>> getAllAudioBook() async {
    List<AudioBook> listAllAudioBook = [];
    try {
      await _firestore.collection("AudioBook").doc("AllAudioBook").collection("AudioBooks").get().then((QuerySnapshot value) {
        for (QueryDocumentSnapshot document in value.docs){
          AudioBook audioBook = AudioBook.fromJson(document.data() as Map<String, dynamic>);
          listAllAudioBook.add(audioBook);
        }
      });
    } catch (e) {
      throw Exception(e);
    }
    return listAllAudioBook;
  }  

}