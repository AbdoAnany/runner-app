import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/style/app_style.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class StepCounterChart extends StatelessWidget {
  final int currentSteps;
  final int goalSteps;

  StepCounterChart({required this.currentSteps, required this.goalSteps});

  @override
  Widget build(BuildContext context) {
    return Container(
   //   margin: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 16.w),
     width: 64.h, height: 64.h,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: goalSteps.toDouble(),
            startAngle: 130,
            endAngle: 130,
            showTicks: false,
            showLabels: false,
            axisLineStyle: AxisLineStyle(
              thickness: 3.w,
          color: Colors.grey.shade300,
              thicknessUnit: GaugeSizeUnit.logicalPixel,
              gradient:       SweepGradient(
                colors: [
                  AppColors.iconHomeColor.withOpacity(.47),
                  AppColors.iconHomeColor.withOpacity(.47),
                  AppColors.iconHomeColor.withOpacity(.10),

                ]  , startAngle: 360,
                endAngle: 52,
                stops: [0,.5,.9]
              ),
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: currentSteps.toDouble(),
                width: 0.15,cornerStyle: CornerStyle.bothCurve,
                sizeUnit: GaugeSizeUnit.factor,
                color: AppColors.dotColor,
               // cornerStyle: CornerStyle.bothCurve,
               //  gradient: const SweepGradient(
               //    colors: [
               //      Colors.pinkAccent,
               //      Colors.pinkAccent,
               //    ],
               //
               //  ),
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.directions_walk,
                        size: 16.w, color: AppColors.iconHomeColor,),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(currentSteps.toString(),
                            style: AppStyle.textStyle14WhiteW400),

                        Container(
                          color: AppColors.textGray,
                          height: 1,
                          width: 26.w,
                        ),
                        // Divider(
                        //   thickness: 3,
                        //   height: 5,
                        //   color: AppColors.textGray,
                        // ),
                        Text(goalSteps.toString(),
                            style: AppStyle.textStyle14GreenW400),
                      ],
                    )
                  ],
                ),
                positionFactor: 0.1,
                angle: 90,
              )
            ],
          ),
        ],
      ),
    //   decoration: BoxDecoration(
    //     shape: BoxShape.circle,
    //     gradient:
    // LinearGradient(
    //       colors: [
    //         AppColors.chartColors.withOpacity(.47),
    //         AppColors.chartColors.withOpacity(.0)
    //       ],
    //     ),
    //   ),
    );
  }
}
