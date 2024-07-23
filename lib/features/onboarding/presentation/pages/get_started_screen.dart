import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/helper/extension.dart';
import 'package:runner_app/core/style/color.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 104.h),
                child: Image.asset(AppImage.onboardingImage),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                height: 303,
                width: 311,
                decoration: BoxDecoration(

                   gradient: const LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
                     colors: [
                       AppColors.border1ContainerColor,
                       AppColors.border2ContainerColor,
                     ]
                   ),
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
                  child: Center(
                    child: Text(
                      AppConst.runnerAppText,
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyle14GrayW400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
