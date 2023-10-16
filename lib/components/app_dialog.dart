import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/widgets/button_widget_primary.dart';
import 'package:audio_book/widgets/button_widget_second.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppDialog {

    static void showDialogLoading(BuildContext context){
        showDialog(
        context: context, 
        builder: (context) => const Dialog.fullscreen(
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
          )),
        ),
      );
    }

    static void showToast(String message, BuildContext context){
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        textColor: Theme.of(context).colorScheme.primary,
        fontSize: 16.0
      );
    }

    static void showDialogNotify(String message, BuildContext context){
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            title: Text("Notification",
              style: AppStyle(themeData: Theme.of(context)).titleTextStyle,
            ),
            content: Text(message,
              style: AppStyle(themeData: Theme.of(context)).defaultTextStyle,
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text("OK",
                  style: AppStyle(themeData: Theme.of(context)).titleTextStyle,
                ),
              ),
            ],
          );
        }
      );
    }

    static showDialogConFirm(BuildContext context, String message) async {
      bool?isConfirm = await showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context, 
        builder: (context) {
          Size size = MediaQuery.of(context).size;
          return FractionallySizedBox(
            heightFactor: 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Comfirm",
                  style: AppStyle(themeData: Theme.of(context)).titleTextStyle,
                ),
                const SizedBox(height: 10,),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppStyle(themeData: Theme.of(context)).defaultTextStyle,
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ButtonSecondWidget(
                          title: "No", 
                          height: size.height / 14, 
                          width: size.width, 
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: ButtonPrimaryWidget(
                          title: "Yes", 
                          height: size.height / 14, 
                          width: size.width, 
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
      return isConfirm ?? false;
    }
}