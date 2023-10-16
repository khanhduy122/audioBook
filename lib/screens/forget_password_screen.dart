import 'package:flutter/material.dart';

import '../components/app_asset.dart';
import '../components/app_style.dart';
import '../widgets/button_widget_primary.dart';
import '../widgets/button_widget_second.dart';
import '../widgets/text_field_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  static const String name = "ForgetPasswordScreen";

  @override
  State<ForgetPasswordScreen> createState() => _ComfirmCodeScreenState();
}

class _ComfirmCodeScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: SizedBox(
                  height: size.height / 13,
                  width: size.width / 4,
                  child: Image.asset(
                    AppAsset.imgLogo,
                    fit: BoxFit.contain,
                  ))),
          Expanded(
              flex: 8,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Forget Password",
                      style: appStyle.titleTextStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Please fill email or phone number and we'll send you a link to get back into your account.",
                      style: appStyle.defaultTextStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      hintText: "Email / Phone Number",
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonPrimaryWidget(
                      title: "Submit",
                      height: size.height / 14,
                      width: size.width,
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
              )),
        ],
      ),
    );
  }
}
