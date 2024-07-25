

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/helper/extension.dart';
import 'package:runner_app/core/style/color.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../1_onboarding/presentation/pages/onboarding_screen.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImage.bgImage))

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
        children: [



          SizedBox(
            width: 247,

            child: Column(
              children: [
                Text('Running App',style: AppStyle.textStyle30WhiteW700,),
                SizedBox(height: 4,),
                Text('Run and earn with our app. Some text Example will be her',
                  textAlign: TextAlign.center,
                  style: AppStyle.textStyle14GrayW400,),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: MaterialButton(
              minWidth: 300,elevation: 0,
                color: AppColors.primary,
                height: 56,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

                child: Text("Get Started",style:AppStyle.textStyle18WhiteW700,),
                onPressed: (){
                  context.pushScreen(const OnBoardingScreen());

                }),
          )
        ],
        ),
            ),
      ),);
  }
}
