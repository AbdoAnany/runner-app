import 'package:runner_app/features/3_home/presentation/widgets/step_counter_chart.dart';
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

    _formattedDate = DateFormat('dd MMM ').format(now);
    _formattedTime = DateFormat('HH : mm : ss').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17.w, vertical: 4.h),
      height: 87.h,
      decoration: AppStyle.decorationHome,
      child: Row(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 16.w),
          child: Badge(
            alignment: Alignment.bottomRight,
            offset: Offset(0,-.9),
            largeSize: 20,
            backgroundColor: AppColors.transparent,
            label: Container(
              decoration: BoxDecoration(shape: BoxShape.circle
              ,color: AppColors.green,
               // border: Border.all(color: AppColors.iconHomeColor.withOpacity(.),width: 3)
                  boxShadow: [
                    BoxShadow(color:  AppColors.iconHomeColor.withOpacity(.4),
                      spreadRadius: 20.w,
                        offset: Offset(0,0,)),
                   // BoxShadow(color:  AppColors.iconHomeColor.withOpacity(.7),offset: Offset(-3,-3,))
                  ]
                  
              ),
              width: 10.w,height: 10.w,
            ),

            child: CircleAvatar(
                radius: 25.r,
                backgroundColor: AppColors.primary,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 4.w),
                  child: Image.asset(AppImage.runnerMan),
                )),
          ),
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
       //  Image.asset(AppImage.radius),
        Expanded(
          child: StepCounterChart(
            currentSteps: 2345,
            goalSteps: 5000,
          ),
        )
      ]),
    );
  }
}

class ChartData {
  ChartData(this.category, this.amount);
  final String category;
  final double amount;
}
