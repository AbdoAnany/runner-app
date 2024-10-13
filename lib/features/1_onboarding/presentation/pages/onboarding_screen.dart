import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/helper/extension.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../2_auth/presentation/pages/SignInPage.dart';
import '../../../2_auth/presentation/pages/login_screen.dart';
import '../widgets/card_onboarding.dart';
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [InkWell(
          onTap: (){
            context.pushScreen( LoginScreen());
          },
          child: Text('Skip',style: AppStyle.textStyle14WhiteW400,)),
        SizedBox(width: 12.w,)
      ],),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80.h,bottom: 20.h,left: 28.w,right: 28.w),
                child: Image.asset(AppImage.onboardingImage,height: 242.h,width: 313.w,),
              ),
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(
                  aspectRatio: 1.2,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  padEnds: true,
                  initialPage: 0),
                  items: [0,1,2,].map((i) {
                    return          CardOnboarding(index: i);
                  }).toList(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ',
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyle14WhiteW400,),
                  InkWell(onTap: (){
                    context.pushScreen( const LoginScreen());
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
