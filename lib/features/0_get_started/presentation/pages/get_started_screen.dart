import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/helper/extension.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/widgets/main_buttom.dart';
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
              image: DecorationImage(image: AssetImage(AppImage.bgImage))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 247,
                child: Column(
                  children: [
                    Text(
                      AppConst.runnerApp,
                      style: AppStyle.textStyle30WhiteW700,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      AppConst.runnerAppText,
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyle14GrayW400,
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: MyMaterialButton(
                      width: 300.w,
                      title: AppConst.getStarted,
                      onPressed: () {
                        context.pushScreen(const OnBoardingScreen());
                      })

                  )
            ],
          ),
        ),
      ),
    );
  }
}
