import 'dart:async';
import 'package:audio_book/components/app_asset.dart';
import 'package:audio_book/components/app_style.dart';
import 'package:audio_book/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/button_widget_primary.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const String name = "OnBoardingScreen";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  int currentIndexPage = 0;
  final PageController _pageController = PageController();
  final StreamController _controllerButonNextPage = StreamController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _controllerButonNextPage.close();
  }
 

  @override
  Widget build(BuildContext context) {

  AppStyle appStyle = AppStyle(themeData: Theme.of(context));
  final Size size= MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(AppAsset.imgBackgroud1, fit: BoxFit.contain,)
                    ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(AppAsset.imgBackgroud2, fit: BoxFit.contain,)
                    )
                ],
              ),
          ),
      
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      currentIndexPage = index;
                      _controllerButonNextPage.sink.add("next page");
                    },
                    children: [
                      itemPageOnboarding(appStyle, "Title One", AppAsset.imgOnBoarding1),
                      itemPageOnboarding(appStyle, "Title Two", AppAsset.imgOnBoarding2),
                      itemPageOnboarding(appStyle, "Title Three", AppAsset.imgOnBoarding3),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                SmoothPageIndicator(  
                  controller: _pageController,  
                  count: 3,  
                  effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10
                  ), 
                  onDotClicked: (index){  
                        
                  }  
                )  
              ],
            )
          ),

          Expanded(
            flex: 2,
            child: StreamBuilder(
              stream: _controllerButonNextPage.stream,
              builder: (context, snapshot) {
                if(currentIndexPage == 2){
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ButtonPrimaryWidget(
                      title: "Lets Get Started", 
                      height: 50, 
                      width: size.width, 
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, SigninScreen.name, (route) => false);
                      },
                    ),
                  );
                }else{
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamedAndRemoveUntil(context, SigninScreen.name, (route) => false);
                          },
                          child: Text("Skip",
                            style: appStyle.defaultTextStyle,
                          ),
                        ),
                  
                        ButtonPrimaryWidget(
                          title: "Next", 
                          height: 50, 
                          width: 100, 
                          onTap: () {
                            currentIndexPage++;
                            _pageController.animateToPage(currentIndexPage, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                          },
                        )
                    ],
                  );
                }
              }
            )
          )
        ],
      ),
    );
  }


  Column itemPageOnboarding(AppStyle appStyle, String tittle, String image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset(image, fit: BoxFit.contain,)),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            tittle, 
            style: appStyle.titleTextStyle 
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Lorem ipsum dolor sit amet la maryame dor sut colondeum.", 
            style: appStyle.defaultTextStyle ,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}