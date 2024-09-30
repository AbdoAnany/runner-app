import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/function.dart';
import '../../../../core/helper/game.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../3_home/presentation/widgets/home_progress_level_steps_bar.dart';
import '../../domain/entities/history_entity.dart';
import '../manager/bloc/runner_data_bloc.dart';

import '../manager/bloc/runner_data_event.dart';
class HistoryList extends StatelessWidget {
  const HistoryList({super.key, this.historyData = const []});
  final List<HistoryEntity> historyData;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.w,).copyWith(bottom: 60.h),
      itemCount: historyData.length,
      itemBuilder: (context, index) {
        final history = historyData[index];
        return HistoryListItem(history: history);
      },
    );
  }
}



class HistoryListItem extends StatelessWidget {
   HistoryListItem({super.key, required this.history,});
  final HistoryEntity history;
 final LevelSystem levelSystem=LevelSystem(currentXP: 0,currentLevel: 1);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(history.id),
      confirmDismiss: (direction) async {
        // Show a confirmation dialog
        bool confirm = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm Deletion"),
              content: const Text("Are you sure you want to delete this history entry? This will also remove the associated XP."),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("DELETE"),
                ),
              ],
            );
          },
        );

        if (confirm) {
          // Delete the history entry and update XP
          levelSystem.addXP(-history.xp);
          context.read<HistoryDataBloc>().add(DeleteHistoryData(history));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("History entry deleted and XP updated")),
          );
        }

        return confirm;
      },
      child: Container(
        height: 72.h,
        decoration: BoxDecoration(
          color: AppColors.bgContainerColor,
          border: Border.all(color: AppColors.border1ContainerColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin:  EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 8.h,),
                Text(
                  AppFunction.getDateDayMonth(history.date),
                  style: AppStyle.textStyle16PrimaryW400,
                ),
                SizedBox(height: 8.h,),
                // Row(
                //   children: [
                //     if (history.pt > 0)
                //       Text(
                //         'PT ${history.pt}',
                //         style: AppStyle.textStyle12PinkW400,
                //       ),
                //     if (history.pt > 0)
                //       Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                //         child: const CircleAvatar(
                //           radius: 2,
                //           backgroundColor: AppColors.textGray,
                //         ),
                //       ),
                //     Text(
                //       '${(history.distance / 1000).toStringAsFixed(2)} km',
                //       style: AppStyle.textStyle12GrayW400,
                //     ),
                //     Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                //       child: const CircleAvatar(
                //         radius: 2,
                //         backgroundColor: AppColors.textGray,
                //       ),
                //     ),
                //     Text(
                //       '${history.kal} kcal',
                //       style: AppStyle.textStyle12GrayW400,
                //     ),
                //   ],
                // )
              ],
            ),
            const Spacer(),
            Text(
              AppFunction.getDecimal(history.xp),
              style: AppStyle.textStyle28GWhiteW800BebasNeue,
            ),
            Text(
              ' xp',
              style: AppStyle.textStyle28GWhiteW800BebasNeue,
            ),
          ],
        ),
      ),
    );
  }
}