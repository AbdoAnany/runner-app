import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/style/app_style.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:runner_app/features/3_home/presentation/bloc/home_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../data/models/user_data_model.dart';

class StepCounterChart extends StatelessWidget {


  const StepCounterChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc,HomeState>(
      builder: (context,s) {
        if(s is HomeLoaded) {
          return _build(s.userDataDataModel);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }


    );
  }

  Widget _build(UserDataDataModel userDataDataModel) {

    return SizedBox(
      width: 64.h, height: 64.h,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: userDataDataModel.xpForNextLevel.toDouble(),
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
                value:  userDataDataModel.currentXP.toDouble(),
                width: 0.15,cornerStyle: CornerStyle.bothCurve,
                sizeUnit: GaugeSizeUnit.factor,
                color: AppColors.dotColor,

              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  //  Icon(Icons.directions_walk, size: 16.w, color: AppColors.iconHomeColor,),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(  userDataDataModel.currentXP.toString(),
                            style: AppStyle.textStyle14WhiteW400),
                        Container(
                          color: AppColors.textGray,
                          height: 1,
                          width: 26.w,
                        ),
                        Text(  userDataDataModel.xpForNextLevel.toString(),
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
    );
  }
}
