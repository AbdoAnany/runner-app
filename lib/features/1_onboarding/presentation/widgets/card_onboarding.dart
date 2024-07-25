

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/helper/extension.dart';
import 'package:runner_app/features/2_auth/presentation/pages/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';

class CardOnboarding extends StatelessWidget {
  const CardOnboarding({super.key,required this.index});
final int index;
  @override
  Widget build(BuildContext context) {
    return   Container(
   //   margin: EdgeInsets.only(top: 20.h),
      height: 303,
      width: 311,
      decoration: BoxDecoration(

        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.border1ContainerColor,
              AppColors.border2ContainerColor,
            ]
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowContainerColor,
            spreadRadius: 1,
            blurRadius: 12,
            offset: const Offset(0, 4), // changes position of shadow
          ),],
        borderRadius: BorderRadius.circular(64),
      ),
      child: Container(

        margin: EdgeInsets.all(1),

        height: 303,
        width: 311,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64),
            color: AppColors.bgContainerColor
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.h,),
            Text('Run',
              style: AppStyle.textStyle21WhiteW700,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
                textAlign: TextAlign.center,
                style: AppStyle.textStyle12GrayW400,),
            ),
            SizedBox(height: 8.h,),
            Center(
              child: SmoothPageIndicator(
                  controller: PageController(initialPage: index),  // PageController
                  count:  3,
                  effect:  ExpandingDotsEffect(
                    dotColor: AppColors.dotColor.withOpacity(.5),
                    dotHeight: 4,
                    expansionFactor: 4,
                    dotWidth: 6,
                    activeDotColor: AppColors.dotColor,
                    spacing: 5,
                  ),  // your preferred effect
                  onDotClicked: (index){
                  }
              ),
            ),
            SizedBox(height: 14.h,),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: MaterialButton(
                  minWidth: 150.w,elevation: 0,
                  color: AppColors.primary,
                  height: 56,splashColor: AppColors.primary.withOpacity(.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),

                  child: SizedBox(width: 120.w,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(),
                        Text("Next",style:AppStyle.textStyle18WhiteW700,),
                        Icon(Icons.arrow_forward,color: AppColors.white,)
                      ],
                    ),
                  ),
                  onPressed: (){
                    context.pushScreen( LoginScreen());

                  }),
            ),

          ],
        ),
      ),
    );
  }
}
