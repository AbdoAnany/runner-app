import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/const/const.dart';
import '../../../../core/style/color.dart';


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
    return Container(
      height: 70.h,
      width: 98.w,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
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
      child: Image.asset(imagePath),
    );
  }
}
