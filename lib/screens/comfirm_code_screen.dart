import 'package:flutter/material.dart';

import '../components/app_asset.dart';
import '../components/app_style.dart';
import '../widgets/button_widget_primary.dart';
import '../widgets/button_widget_second.dart';
import '../widgets/text_field_widget.dart';

class ComfirmCodeScreen extends StatefulWidget {
  const ComfirmCodeScreen({super.key});

  static const String name = "ComfirmCodeScreen";

  @override
  State<ComfirmCodeScreen> createState() => _ComfirmCodeScreenState();
}

class _ComfirmCodeScreenState extends State<ComfirmCodeScreen> {
  @override
  Widget build(BuildContext context) {

    ThemeData themeData = Theme.of(context);
    AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size= MediaQuery.of(context).size;
    
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: size.height/13,
              width: size.width/4,
              child: Image.asset(AppAsset.imgLogo, fit: BoxFit.contain,)
            )
          ),
          
          Expanded(
            flex: 8,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Confirmation Code",
                    style: appStyle.titleTextStyle,
                  ),
                   const SizedBox(height: 20,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Enter the confirmation code we sent to\n",
                          style: appStyle.defaultTextStyle
                        ),
                        TextSpan(
                          text: "lekhanhduy9412@gmail.com",
                          style: appStyle.textImportant
                        )
                      ]
                    )
                  ),

                  const SizedBox(height: 20,),
                  TextFieldWidget(
                    hintText: "Confirmation Code",
                    onChanged: (value) {
                      
                    },
                  ),

                  const SizedBox(height: 20,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Didn’t receive the code? ",
                          style: appStyle.defaultTextStyle
                        ),
                        TextSpan(
                          text: "Resend",
                          style: appStyle.textImportant
                        )
                      ]
                    )
                  ),

                  const SizedBox(height: 20,),
                    ButtonPrimaryWidget(
                      title: "Submit", 
                      height: size.height / 14, 
                      width: size.width, 
                      onTap: () {
                        
                      },
                    ),
            
                    const SizedBox(height: 20,),
                    ButtonSecondWidget(
                      title: "Cancle", 
                      height: size.height / 14, 
                      width: size.width, 
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}