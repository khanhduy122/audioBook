import 'package:audio_book/components/app_asset.dart';
import 'package:audio_book/screens/home_screen.dart';
import 'package:audio_book/screens/library_screen.dart';
import 'package:audio_book/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String name = "MainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    return PersistentTabView(
      context,
      navBarStyle: NavBarStyle.style6,
      screens: const  [
        HomeScreen(), 
        SearchScreen(), 
        LibraryScreen()
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: Image.asset(
            AppAsset.icHome,
            color: themeData.colorScheme.onPrimary,
          ),
          title: "Home",
          activeColorPrimary: themeData.colorScheme.primaryContainer,
        ),
        PersistentBottomNavBarItem(
            icon: Image.asset(
              AppAsset.icSearch,
              color: themeData.colorScheme.onPrimary,
            ),
            activeColorPrimary: themeData.colorScheme.primaryContainer,
            title: "Search"),
        PersistentBottomNavBarItem(
            icon: Image.asset(
              AppAsset.icLibrary,
              color: themeData.colorScheme.onPrimary,
            ),
            activeColorPrimary: themeData.colorScheme.primaryContainer,
            title: "Library")
      ],
      confineInSafeArea: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      backgroundColor: themeData.colorScheme.background,
    );
  }
}

