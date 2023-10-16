import 'package:audio_book/components/app_asset.dart';
import 'package:audio_book/modules/firebase/firebase_bloc.dart';
import 'package:audio_book/modules/firebase/firebase_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/data_provider.dart';
import 'main_screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  static const String name = "LoadingScreen";

  @override
  Widget build(BuildContext context) {
    final FirebaseBloc getDataAppBloc = FirebaseBloc();
    getDataAppBloc.add(GetDataAppEvent());
    return Scaffold(
      body: BlocListener(
        bloc: getDataAppBloc,
        listener: (context, state) {
          if(state is DataAppState){
            context.read<DataProvider>().initData(recommend: state.recommend!, bestSeller: state.bestSeller!, 
            newRelease: state.newRelease!, trendingNow: state.trendingNow!, allAudioBook: state.allAudioBook!);
            Navigator.pushNamedAndRemoveUntil(context, MainScreen.name, (route) => false);
          }
        },
        child: Center(
          child: Image.asset(AppAsset.imgLogo),
        ),
      ),
    );
  }
}
