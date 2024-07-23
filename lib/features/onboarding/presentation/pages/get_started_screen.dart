import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/style/color.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';

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
              image: DecorationImage(image: AssetImage(AppImage.bgImage))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 148),
                child: Image.asset(AppImage.onboardingImage),
              ),
              Text(
                AppConst.runnerApp,
                style: AppStyle.textStyle30WhiteW700,
              ),
              SizedBox(
                width: 247,
                child: Text(
                  AppConst.runnerAppText,
                  textAlign: TextAlign.center,
                  style: AppStyle.textStyle14GrayW400,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: MaterialButton(
                    minWidth: 300.w,
                    elevation: 0,
                    color: AppColors.primary,
                    height: 56.h,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      AppConst.getStarted,
                      style: AppStyle.textStyle18WhiteW700,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
