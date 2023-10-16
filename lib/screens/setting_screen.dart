import 'package:audio_book/components/app_asset.dart';
import 'package:audio_book/components/app_dialog.dart';
import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/modules/firebase/firebase_bloc.dart';
import 'package:audio_book/screens/profile_detail_screen.dart';
import 'package:audio_book/screens/signin_screen.dart';
import 'package:audio_book/screens/subscription_screen.dart';
import 'package:audio_book/widgets/button_widget_second.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static const String name = "SettingScreen";

  @override
  Widget build(BuildContext context) {
    
    User user =FirebaseAuth.instance.currentUser!;
    final ThemeData themeData = Theme.of(context);
    final AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        elevation: 1,
        automaticallyImplyLeading: true,
        title: Text(
          "Setting",
          style: appStyle.titleTextStyle,
        ),
        centerTitle: true,
      ),
    
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: size.height / 8,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: StatefulBuilder(
              builder: (context, setState) {
                return BlocListener(
                  bloc: BlocProvider.of<FirebaseBloc>(context),
                  listener: (context, state) {
                    if(state is UserState && state.user != null){
                      setState(() {
                        user = state.user!;
                      },);
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: size.height / 12,
                        width: size.width / 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size.height / 5),
                          image: user.photoURL != null ? DecorationImage(
                            image: NetworkImage(user.photoURL!),
                            fit: BoxFit.fill
                          ) : const DecorationImage(
                            image: AssetImage(AppAsset.imgAvatarDefault),
                            fit: BoxFit.fill
                          )
                        )
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(user.displayName! == "" ? user.email! : user.displayName!,
                            style: appStyle.titleTextStyle,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileDetailScreen(),));
                            },
                            child: Text("View Profile",
                              style: appStyle.textButtonSecond,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
            ),
          ),
    
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: themeData.colorScheme.surface
            ),
          ),
          Column(
            children: [
              _optionSetting("Notifications", context),
              _optionSetting("Data and Storages", context)
            ],
          ),
    
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: themeData.colorScheme.surface
            ),
          ),
          Column(
            children: [
              _optionSetting(
                "Subscription", context,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscriptionScreen(),));
                },
              ),
              _optionSetting("Linked Account", context)
            ],
          ),
    
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: themeData.colorScheme.surface
            ),
          ),
          _optionSetting("About Audibooks", context),
    
          const SizedBox(height: 20,),
          ButtonSecondWidget(
            title: "Sign Out", 
            height: size.height / 12, 
            width: size.width / 1.5, 
            onTap: () async {
              if(await AppDialog.showDialogConFirm(context, "Are you sure you want to sign out of the app?")){
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SigninScreen(),), (route) => false);
                });
              }
            },
          )
    
    
        ],
      ),
    );
  }

  Widget _optionSetting(String title, BuildContext context, {Function()? onTap}){
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height / 14,
        width: size.width,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Theme.of(context).colorScheme.surface, width: 2)
          )
        ),
        child: Text(title,
          style: AppStyle(themeData: Theme.of(context)).defaultTextStyle,
        ),
      ),
    );
  }
}