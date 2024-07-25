import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/color.dart';
import '../../../../my_app.dart';


class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSocialButton( AppImage.googleImage,),
        _buildSocialButton(AppImage.facebookImage,),
        _buildSocialButton(AppImage.twitterImage,),
      ],
    );
  }

  Widget _buildSocialButton(String imagePath) {
    return  Container(
        height: 70.h,
        width: 98.w,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        margin: EdgeInsets.symmetric(vertical: 28.h, horizontal: 0.w),
        decoration: BoxDecoration(
          color: AppColors.bgContainerColor,
          border: Border.all(color: AppColors.border1ContainerColor),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowContainerColor,
              spreadRadius: 1,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child:InkWell(
          onTap: (){
            toastification.show(
              alignment: Alignment.bottomCenter,
              context: Get.context, // optional if you use ToastificationWrapper
              title: Text('This service is not working'),
              type: ToastificationType.warning,showProgressBar: false,
              style: ToastificationStyle.flatColored,
              autoCloseDuration: const Duration(seconds: 3),
            );
          },
          child: Image.asset(imagePath),
      ),
    );
  }
}
