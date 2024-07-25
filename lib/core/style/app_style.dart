




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color.dart';

class AppStyle{

  static TextStyle textStyle30WhiteW700 = TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: "Quicksand",
      fontSize: 30.w);
  static TextStyle textStyle21WhiteW700 = TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: "Quicksand",
      fontSize: 21.w);
  static TextStyle textStyleNormal21WhiteW700 = TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w700,

      fontSize: 21.w);
  static TextStyle textStyle18WhiteW700 = TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: "Quicksand",
      fontSize: 18.w);

  // static TextStyle textStyle14WhiteW400 = TextStyle(
  //     color: AppColors.white,
  //     fontWeight: FontWeight.w400,
  //
  //     fontSize: 14.w);

  static TextStyle textStyle14GrayW400 =TextStyle(
      color: AppColors.textGray,
      fontWeight: FontWeight.w400,
   
      fontSize: 14.w);
  static TextStyle textStyle15GreenW500 =TextStyle(
      color: AppColors.green,
      fontWeight: FontWeight.w500,
      fontSize: 14.w);
  static TextStyle textStyle14GrayerW400 =TextStyle(
      color: AppColors.textGray2,
      fontWeight: FontWeight.w400,

      fontSize: 14.w);
  static TextStyle textStyle14WhiteW400 =TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w400,
      fontSize: 14.w);
  static TextStyle textStyle10WhiteW400 =TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w400,
      fontSize: 10.w);
  static TextStyle textStyle48WhiteW400 =TextStyle(
      color: AppColors.white,fontFamily: "BebasNeue",
      fontWeight: FontWeight.w400,
      fontSize: 48.w);
  static TextStyle textStyle21WhiteW400 =TextStyle(
      color: AppColors.white,fontFamily: "BebasNeue",
      fontWeight: FontWeight.w400,
      fontSize: 21.w);


  static TextStyle textStyle14PrimaryW400 =TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w400,
      fontSize: 14.w);


  static TextStyle textStyle12GrayW400 =TextStyle(
      color: AppColors.textGray,
      fontWeight: FontWeight.w400,

      fontSize: 12.w);
  static TextStyle textStyle12PinkW400 =TextStyle(
      color: AppColors.dotColor,
      fontWeight: FontWeight.w400,

      fontSize: 12.w);

  static TextStyle textStyle12WhiteW400 =TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w400,

      fontSize: 12.w);
  static TextStyle textStyle16GWhiteW800 =TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w800,

      fontSize: 16.w);
static TextStyle textStyle20GWhiteW800 =TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w800,

      fontSize: 20.w);
static TextStyle textStyle24GWhiteW800BebasNeue =TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w800,
      fontFamily: "BebasNeue",
      fontSize: 24.w);

static TextStyle textStyle20GoldW800 =TextStyle(
      color: AppColors.levelHomeColor,
      fontWeight: FontWeight.w700,
    fontFamily: "Quicksand",
      fontSize: 20.w);



  static  InputDecoration inputDecoration({hintText}) => InputDecoration(
  filled: true,
  hintText: hintText,hintStyle:  TextStyle(color: AppColors.textGray),

  fillColor: AppColors.bgFiledColor,
  border: OutlineInputBorder(
  borderSide: BorderSide(color: AppColors.primary),

  borderRadius: BorderRadius.circular(10.r),
  ),
  enabledBorder: OutlineInputBorder(
  borderSide: BorderSide(color: AppColors.primary.withOpacity(.8)),

  borderRadius: BorderRadius.circular(10.r),
  )
  );
}