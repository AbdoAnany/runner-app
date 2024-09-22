




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
      fontSize: 14.w);  static TextStyle textStyle14GreenW400 =TextStyle(
      color: AppColors.green,
      fontWeight: FontWeight.w400,
      fontSize: 16.w);
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
  static TextStyle textStyle16PrimaryW400 =TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w400,
      fontSize: 16.w);


  static TextStyle textStyle12GrayW400 =TextStyle(
      color: AppColors.textGray,
      fontWeight: FontWeight.w400,

      fontSize: 12.w);  static TextStyle textStyle12GrayLightW400 =TextStyle(
      color: AppColors.iconHomeColor,
      fontWeight: FontWeight.w400,

      fontSize: 12.w);
  static TextStyle textStyle12PinkW400 =TextStyle(
      color: AppColors.dotColor,
      fontWeight: FontWeight.w400,

      fontSize: 12.w);
  static TextStyle textStyle14PinkW400 =TextStyle(
      color: AppColors.dotColor,
      fontWeight: FontWeight.w400,

      fontSize: 14.w);

  static TextStyle textStyle12WhiteW400 =TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w400,

      fontSize: 12.w);  static TextStyle textStyle12GreenW400 =TextStyle(
      color: AppColors.green,
      fontWeight: FontWeight.w400,

      fontSize: 12.w);
  static TextStyle textStyle16GWhiteW800 =TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w800,
      fontSize: 16.w);
  static TextStyle textStyle16GWhiteQuicksandW800 =TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w800,
      fontFamily: "Quicksand",
      fontSize: 18.w);
static TextStyle textStyle20GWhiteW800 =TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w800,

      fontSize: 20.w);
static TextStyle textStyle24GWhiteW800BebasNeue =TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w800,
      fontFamily: "BebasNeue",
      fontSize: 24.w);
static TextStyle textStyle28GWhiteW800BebasNeue =TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w800,
    letterSpacing: 2,
      fontFamily: "BebasNeue",
      fontSize: 28.w);

static TextStyle textStyle28GGoldW800BebasNeue =TextStyle(
    color: AppColors.storeCard2,
    fontWeight: FontWeight.w800,letterSpacing: 2,
    fontFamily: "BebasNeue",
    fontSize: 28.w);


static TextStyle textStyle14GGoldW800BebasNeue =TextStyle(
    color: AppColors.storeCard2,
    fontWeight: FontWeight.w800,
    letterSpacing: 2,
    // fontFamily: "BebasNeue",
    fontSize: 34.w);

static TextStyle textStyle20GoldW800 =TextStyle(
      color: AppColors.levelHomeColor,
      fontWeight: FontWeight.w700,
    fontFamily: "Quicksand",
      fontSize: 20.w);

static TextStyle textStyle16GoldW800 =TextStyle(
      color: AppColors.levelHomeColor,
      fontWeight: FontWeight.w700,
    fontFamily: "Quicksand",
      fontSize: 16.w);

  static  BoxDecoration  decorationHome= BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  border: Border.all(  color: AppColors.white.withOpacity(.17)),
  color: AppColors.white.withOpacity(.10));

  static  InputDecoration inputDecoration({String hintText='',void Function()? changeObscureText,obscureText=true}) =>

      InputDecoration(
  filled: true,
  hintText:hintText,
  hintStyle: const TextStyle(color: AppColors.textGray),
  fillColor: AppColors.bgFiledColor,
  suffixIcon: hintText.contains("password")?InkWell(
 // onTap: changeObscureText??(){},
      child:  Icon(
  obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
  color: AppColors.primary,
  )
  ):const SizedBox(height: 25,),
  border: OutlineInputBorder(
  borderSide: BorderSide(color: AppColors.primary),
  borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: OutlineInputBorder(
  borderSide: BorderSide(color: AppColors.primary.withOpacity(.8)),
  borderRadius: BorderRadius.circular(10),
  ),
  )

  ;
}