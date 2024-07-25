


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';

class DailyActivityCard extends StatefulWidget {
  const DailyActivityCard({super.key});

  @override
  State<DailyActivityCard> createState() => _DailyActivityCardState();
}

class _DailyActivityCardState extends State<DailyActivityCard> {
  String _formattedDate = '';
  String _formattedTime = '';

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();

    _formattedDate = DateFormat('dd MMM').format(now);
    _formattedTime = DateFormat('HH : mm : ss').format(now);

  }
  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 4.h),
      height: 87.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white.withOpacity(.17)),
      child: Row(children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20.0.h, horizontal: 16.w),
          child: CircleAvatar(
              radius: 25.r,
              backgroundColor: AppColors.primary,
              child: Image.asset(AppImage.runnerMan)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formattedDate,
              style: AppStyle.textStyle12GrayW400,
            ),
            Text(
              'Today',
              style: AppStyle.textStyle15GreenW500,
            ),
            Text(
              _formattedTime,
              style: AppStyle.textStyle12GrayW400,
            ),
          ],
        ),
        Spacer(),
        Image.asset(AppImage.radius)
      ]),
    );
  }
}
