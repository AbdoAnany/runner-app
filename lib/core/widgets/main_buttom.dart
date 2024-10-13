import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/app_style.dart';
import '../style/color.dart';

class MyMaterialButton extends StatelessWidget {
  MyMaterialButton(
      {super.key, required this.onPressed, required this.title, this.width=300});
  void Function()? onPressed;
  final double? width;
  final String title;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: width,
        elevation: 0,
        color: AppColors.primary,
        height: 48.h,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        onPressed: onPressed,
        child: Text(
          title,
          style: AppStyle.textStyle18WhiteW700,
        ));
  }
}
