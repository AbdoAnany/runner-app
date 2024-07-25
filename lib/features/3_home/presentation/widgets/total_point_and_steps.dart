import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';

class TotalPointAndSteps extends StatelessWidget {
  const TotalPointAndSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
       //   SizedBox(width: 17.w,),
          Container(
            height: 125.h,
            width: 154.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white.withOpacity(.17)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                '53,524',
                style: AppStyle.textStyle48WhiteW400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImage.steps,
                    color: AppColors.iconHomeColor,
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'Steps',
                    style: AppStyle.textStyle12GrayW400,
                  ),
                ],
              )
            ]),
          ),

          Container(
            height: 125.h,
            width: 154.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white.withOpacity(.17)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                '1000',
                style: AppStyle.textStyle48WhiteW400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.coin_1,
                    color: AppColors.iconHomeColor,
                    size: 20.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'Earned Points',
                    style: AppStyle.textStyle12GrayW400,
                  ),
                ],
              )
            ]),
          ),
      //    SizedBox(width: 17.w,),
        ],
      ),
    );
  }
}
