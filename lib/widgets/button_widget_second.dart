import 'package:audio_book/components/app_style.dart';
import 'package:flutter/material.dart';

class ButtonSecondWidget extends StatelessWidget {
  const ButtonSecondWidget({super.key, required this.title, required this.height , required this.width, required this.onTap, this.iconAssets});

  final String title;
  final Function() onTap;
  final double height;
  final double width;
  final String? iconAssets;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        fixedSize: Size(width, height),
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(8)
        )
      ),
      onPressed: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconAssets != null ? Image.asset(iconAssets!, color: Theme.of(context).colorScheme.outline) : Container(),
          const SizedBox(width: 5,),
          Text(title,
            style: AppStyle(themeData: Theme.of(context)).textButtonSecond,
          ),
        ],
      )
    );
  }
}