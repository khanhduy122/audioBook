import 'package:audio_book/components/app_dialog.dart';
import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/modules/firebase/firebase_bloc.dart';
import 'package:audio_book/modules/firebase/firebase_event.dart';
import 'package:audio_book/widgets/button_widget_primary.dart';
import 'package:audio_book/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.title, required this.value});

  final String title;
  final String value;


  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController _editProfileController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _editProfileController.text =widget.value;
  }

  @override
  void dispose() {
    super.dispose();
    _editProfileController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    final AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        elevation: 1,
        automaticallyImplyLeading: true,
        title: Text(
          widget.title,
          style: appStyle.titleTextStyle,
        ),
        centerTitle: true,
      ),
    
      body: BlocListener(
        bloc: BlocProvider.of<FirebaseBloc>(context),
        listener: (context, state) {
          if(state is UserState){
            if(state.isLoading == true){
              AppDialog.showDialogLoading(context);
            }
            if(state.user != null ){
              Navigator.pop(context);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              TextFieldWidget(
                controller: _editProfileController,
                hintText: widget.title
              ),
                
              const SizedBox(height: 20,),
              ButtonPrimaryWidget(
                title: "Save", 
                height: size.height / 14, 
                width: size.width / 1.5, 
                onTap: () {
                  BlocProvider.of<FirebaseBloc>(context).add(UpdateUserProfileEvent(displayName: _editProfileController.text));
                },
              )
                
            ],
          ),
        ),
      ),
    );
  }
}

