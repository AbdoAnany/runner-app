


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/function.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../data/entities/history_entity.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key,this.historyData=const []});
final  List<HistoryEntity> historyData;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemCount: historyData.length,
      itemBuilder: (context, index) {
        final history = historyData[index];
        return HistoryListItem(history: history);
      },
    );
  }
}

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({super.key, required this.history});
  final HistoryEntity history;
  @override
  Widget build(BuildContext context) {
    return Container(height: 72.h,
      decoration: BoxDecoration(
        color: AppColors.bgContainerColor,
        border: Border.all(color: AppColors.border1ContainerColor),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppFunction.getDateDayMonth(history.date),
                style: AppStyle.textStyle14PrimaryW400,
              ),
              Row(
                children: [
                  if (history.pt > 0)
                    Text(
                      'PT ${history.pt}',
                      style: AppStyle.textStyle12PinkW400,
                    ),
                  if (history.pt > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        radius: 2,
                        backgroundColor: AppColors.textGray,
                      ),
                    ),
                  Text(
                    '${(history.distance / 1000).toStringAsFixed(2)} km',
                    style: AppStyle.textStyle12GrayW400,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      radius: 2,
                      backgroundColor: AppColors.textGray,
                    ),
                  ),
                  Text(
                    '${history.kal} kcal',
                    style: AppStyle.textStyle12GrayW400,
                  ),
                ],
              )
            ],
          ),
          Spacer(),
          Text(
            AppFunction.getDecimal(history.steps),
            style: AppStyle.textStyleNormal21WhiteW700,
          ),
          Text(
            ' steps',
            style: AppStyle.textStyle14WhiteW400,
          ),
        ],
      ),
    );}
}