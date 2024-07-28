// statistics_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:runner_app/core/helper/function.dart';
import 'package:runner_app/core/style/app_style.dart';
import 'package:runner_app/core/style/color.dart';

import '../manager/bloc/runner_data_state.dart';

class StatisticsWidget extends StatelessWidget {
  final RunnerDataLoaded state;

  const StatisticsWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(height: 96.h,
      margin: EdgeInsets.symmetric(horizontal: 17.w, vertical: 17.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration:  AppStyle.decorationHome,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn(
            icon: Iconsax.timer_1,
            value: '${AppFunction.getHistoryCount(state.historyData.length)} H',
            label: 'Time',
          ),
          _buildStatColumn(
            icon: Iconsax.routing,
            value: '${AppFunction.getDistance(state.historyData.fold(0, (accumulator, element) => (accumulator + element.distance).toInt())/1000 )} KM',
            label: 'Distance',
          ),
          _buildStatColumn(
            icon: Iconsax.heart_circle,
            iconColor: AppColors.dotColor,
            value: '${

128
            } BPM',
            label: 'Heart Beat',
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn({
    required IconData icon,
    required String value,
    required String label,
    Color? iconColor,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor ?? AppColors.white),
        SizedBox(height: 4.h,),
        Text(
          value,
          style: AppStyle.textStyle24GWhiteW800BebasNeue,
        ),
        Text(
          label,
          style: AppStyle.textStyle12GrayW400,
        ),
      ],
    );
  }
}
