import 'package:audio_book/components/routes.dart';
import 'package:audio_book/models/data_provider.dart';
import 'package:audio_book/modules/firebase/firebase_bloc.dart';
import 'package:audio_book/screens/splash_screen.dart';
import 'package:audio_book/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        routes: routes,
        home: const SplashScreen(),
        builder: (context, child) {
          return BlocProvider(
            create: (context) => FirebaseBloc(),
            child: ChangeNotifierProvider<DataProvider>(
              create: (context) => DataProvider(),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
