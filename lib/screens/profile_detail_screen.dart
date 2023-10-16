import 'package:audio_book/components/app_asset.dart';
import 'package:audio_book/modules/firebase/firebase_bloc.dart';
import 'package:audio_book/screens/edit_profile_scren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/app_style.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => __ProfileDetailScreenStateState();
}

class __ProfileDetailScreenStateState extends State<ProfileDetailScreen> {

  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    final AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size = MediaQuery.of(context).size;

    return BlocListener(
      bloc: BlocProvider.of<FirebaseBloc>(context),
      listener: (context, state) {
        if(state is UserState && state.user != null){
          setState(() {
            user = state.user!;
          },);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeData.colorScheme.background,
          elevation: 1,
          automaticallyImplyLeading: true,
          title: Text(
            "Profile",
            style: appStyle.titleTextStyle,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: size.height / 3,
              decoration: BoxDecoration(
                 border: Border(
                  bottom: BorderSide(color: Theme.of(context).colorScheme.surface, width: 2)
                )
              ),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      height: size.height / 6,
                      width: size.width / 3,
                      decoration: BoxDecoration(
                        image: user.photoURL != null ? DecorationImage(
                          image: NetworkImage(user.photoURL!),
                          fit: BoxFit.fill
                        ): const DecorationImage(
                          image: AssetImage(AppAsset.imgAvatarDefault),
                          fit: BoxFit.fill
                        ),
                        borderRadius: BorderRadius.circular(10),
                       
                      ),
                    ),
        
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image.asset(AppAsset.icCamera)
                    )
                  ],
                ),
              ),
            ),
        
            _itemEditProfile(title: "Display Name", value: user.displayName!, context: context, 
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  
                EditProfileScreen(title: "Display Name", value: user.displayName!),));
              },
            ),
        
            _itemEditProfile(title: "UserName", value: user.displayName!, context: context, 
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  
                EditProfileScreen(title: "UserName", value: user.displayName!),));
              },
            ),
        
            _itemEditProfile(title: "Email", value: user.email!, context: context, 
              onTap: () {
              },
            ),
        
            _itemEditProfile(title: "Phone", value: user.phoneNumber ?? "", context: context, 
              onTap: () {
              },
            ),
        
            _itemEditProfile(title: "Date Birth", value: "15/04/2002", context: context, 
              onTap: () {
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _itemEditProfile({ required String title, required String value , required BuildContext context, required Function() onTap}){
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
        child: Row(
          children: [
            Expanded(
              child: Text(title,
                style: AppStyle(themeData: Theme.of(context)).defaultTextStyle,
              ),
            ),
            Expanded(
              child: Text(value,
                overflow: TextOverflow.ellipsis,
                style: AppStyle(themeData: Theme.of(context)).defaultTextStyle.copyWith(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}