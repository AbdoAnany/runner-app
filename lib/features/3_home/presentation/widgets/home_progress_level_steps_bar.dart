

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import 'gradient_Progress_painter.dart';

class HomeProgressLevelStepsBar extends StatefulWidget {
  const HomeProgressLevelStepsBar({super.key});

  @override
  State<HomeProgressLevelStepsBar> createState() => _HomeProgressLevelStepsBarState();
}

class _HomeProgressLevelStepsBarState extends State<HomeProgressLevelStepsBar> {
  int currentSteps = 14000;
  int goalSteps = 15000;
  double progress = 0;
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    progress = currentSteps / goalSteps;


  }
  @override
  Widget build(BuildContext context) {
    return   Container(
      height:
      48.0.h, // Use static height if you're not using screen sizes
      margin: EdgeInsets.only(left: 10.0.w,right: 10.0.w, bottom: 0.0.h,),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${NumberFormat("#,000").format(currentSteps)} /',
                        style: AppStyle.textStyle12GrayW400,
                      ),
                      Text(
                        NumberFormat("#,000").format(goalSteps),
                        style: AppStyle.textStyle20GWhiteW800,
                      ),
                      Text(
                        ' steps', style: AppStyle.textStyle12GrayW400,
                      ),
                      const Spacer(),
                      Text(
                        'Level 5',
                        style: AppStyle.textStyle20GoldW800,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                      height: 10.0.h, width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),

                        color: AppColors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadowContainerColor,
                            spreadRadius: 1,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CustomPaint(
                        painter: GradientProgressPainter(
                          progress: progress,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.bar1HomeColor,
                              AppColors.bar2HomeColor,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            AppImage.levelBadge,
            width: 48.0.w,
            height: 48.h,
          ),
        ],
      ),
    );
  }
}
