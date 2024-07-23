




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color.dart';

class AppStyle{

  static TextStyle textStyle30WhiteW700 = TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: "Quicksand",
      fontSize: 30.r);
  static TextStyle textStyle21WhiteW700 = TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: "Quicksand",
      fontSize: 21.r);
  static TextStyle textStyle18WhiteW700 = TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: "Quicksand",
      fontSize: 18.r);

  static TextStyle textStyle14GrayW400 =TextStyle(
      color: AppColors.textGray,
      fontWeight: FontWeight.w400,
   
      fontSize: 14.w);
  static TextStyle textStyle14WhiteW400 =TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w400,
      fontSize: 14.w);
  static TextStyle textStyle14PrimaryW400 =TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w400,
      fontSize: 14.w);
  static TextStyle textStyle12GrayW400 =TextStyle(
      color: AppColors.textGray,
      fontWeight: FontWeight.w400,

      fontSize: 12.w);
}