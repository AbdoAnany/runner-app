import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/helper/extension.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../widgets/card_onboarding.dart';
import '../../../2_auth/presentation/pages/login_screen.dart';
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 90),
                child: Image.asset(AppImage.onboardingImage),
              ),
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(  height: 310.h,
                  aspectRatio: 1.2,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  padEnds: true,
                  initialPage: 0),
                  items: [0,1,2,].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return     CardOnboarding(index: i);
                      },
                    );
                  }).toList(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyle14WhiteW400,),
                  TextButton(onPressed: (){
                    context.pushScreen( LoginScreen());
                  }, child:   Text('Sign In',
                    textAlign: TextAlign.center,
                    style: AppStyle.textStyle14PrimaryW400,),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
