import 'package:audio_book/components/app_asset.dart';
import 'package:audio_book/widgets/button_widget_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/app_style.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    final AppStyle appStyle = AppStyle(themeData: themeData);
    final Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Subscriptions",
          style: appStyle.titleTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Container(
                height: size.height / 2.5,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage(AppAsset.imgSubscription1),
                    fit: BoxFit.fill
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Text(
                "Take these all!",
                style: appStyle.titleTextStyle.copyWith(fontSize: 24.sp, color: themeData.colorScheme.outline),
              ),
              const SizedBox(height: 10,),
              Text(
                "What you get from subscription:",
                style: appStyle.defaultTextStyle,
              ),
              const SizedBox(height: 10,),
              Column(
                children: [
                  _itemBenefit("Read and listen to all premium books without limits."),
                  _itemBenefit("Ad-free experience on any platform."),
                  _itemBenefit("Exclusive content from hand-picked creators."),
                  _itemBenefit("Cancel anytime without anymore charged."),
                ],
              ),
              const SizedBox(height: 20,),
              Container(
                height: size.height / 6,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage(AppAsset.imgSubscription2),
                    fit: BoxFit.fill
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Center(
                child: Text(
                  "Access Anywhere",
                  style: appStyle.titleTextStyle.copyWith(fontSize: 24.sp, color: themeData.colorScheme.outline),
                ),
              ),
              const SizedBox(height: 10,),
              Center(
                child: Text(
                  "One account for any platform",
                  style: appStyle.defaultTextStyle,
                ),
              ),
              const SizedBox(height: 20,),
              const SizedBox(height: 20,),
              Container(
                height: size.height / 2.5,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage(AppAsset.imgSubscription3),
                    fit: BoxFit.fill
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Center(
                child: Text(
                  "Phone - Tablet - Desktop",
                  style: appStyle.defaultTextStyle,
                ),
              ),
              const SizedBox(height: 20,),
              Text(
                "Subscribe Now",
                style: appStyle.defaultTextStyle,
              ),
              const SizedBox(height: 20,),
              ButtonPrimaryWidget(
                title: "Subscribe", 
                height: size.height/14, 
                width: size.width, 
                onTap: () {
                  
                },
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemBenefit(String title){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.h,
          width: 30.w,
          child: Image.asset(AppAsset.icTick, fit: BoxFit.scaleDown,),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Text(
            title,
            style: AppStyle(themeData: Theme.of(context)).defaultTextStyle,
          )
        )
      ],
    );
  }
}