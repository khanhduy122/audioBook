import 'package:audio_book/components/app_style.dart';
import 'package:flutter/material.dart';

class ButtonPrimaryWidget extends StatelessWidget {
  const ButtonPrimaryWidget({super.key, required this.title, required this.height , required this.width ,required this.onTap, this.iconAssets});

  final String title;
  final Function() onTap;
  final double height;
  final double width;
  final String? iconAssets;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
      ),
      onPressed: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconAssets != null ? Image.asset(iconAssets!, color: Colors.white) : Container(),
          const SizedBox(width: 5,),
          Text(title,
            style: AppStyle(themeData: Theme.of(context)).textButtonPrimary,
          ),
        ],
      )
    );
  }
}