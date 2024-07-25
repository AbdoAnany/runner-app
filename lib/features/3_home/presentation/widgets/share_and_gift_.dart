


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';

class ShareAndGiftWidget extends StatelessWidget {
  const ShareAndGiftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.h,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF82AFFF), // Light Blue
            Color(0xFFF14985), // Light Pink
          ],
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Image or illustration


          // Text elements
          Expanded(
            flex: 5,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 14.h),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Share & Get',
                    style: AppStyle.textStyle18WhiteW700,
                  ),
                  SizedBox(height: 4.0.h),
                  Text(
                    'Get 2x point for every step, only valid for today',
                    style:     AppStyle.textStyle14WhiteW400,
                  ),
                  SizedBox(height: 6.0.h),
                  // Share button

                  Container(
                    width: 65.0.w,height: 24.0.h,
                    padding: EdgeInsets.only(left: 4.0.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white.withOpacity(.17)),
                      color: AppColors.bgContainerColor.withOpacity(.2),
                      borderRadius: BorderRadius.circular(16.0),
                    ),child: Row(
                    children: [
                      Icon(Icons.share_outlined, color: Colors.white,size: 11.w,),

                      Text('  Share',   style:     AppStyle.textStyle10WhiteW400,),
                    ],
                  ),
                  )

                ],
              ),
            ),
          ),
          Image.asset(
            AppImage.giftPerson, // Replace with your image path
            fit: BoxFit.fill,width: 118.w,height: 95.h,
          ),
        ],
      ),
    );
  }
}
