// statistics_widget.dart

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:runner_app/core/helper/function.dart';
import 'package:runner_app/core/style/app_style.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:runner_app/features/4_history/data/models/history_data_model.dart';

import '../../../../core/const/const.dart';
import '../../../../core/helper/game.dart';
import '../../../../core/share/text_field.dart';
import '../../../../core/widgets/main_buttom.dart';
import '../../../../dependency_injection.dart';
import '../../../../my_app.dart';
import '../../domain/entities/history_entity.dart';
import '../manager/bloc/runner_data_bloc.dart';
import '../manager/bloc/runner_data_event.dart';
import '../manager/bloc/runner_data_state.dart';

class StatisticsWidget extends StatelessWidget {
  final HistoryDataLoaded state;

  StatisticsWidget({super.key, required this.state});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int xp = state.historyData.fold(0, (accumulator, element) => (accumulator + element.xp));
    print(xp);

    // Initialize Player with current XP and check for level up
    LevelSystem levelSystem = LevelSystem(currentXP: xp,currentLevel: 1);

    // Update player's level based on current XP
    levelSystem.addXP(0); // Trigger level checking without additional XP

    print("level:  " + levelSystem.currentLevel.toString());
    print("currentXP:  " + levelSystem.currentXP.toString());
    print("xpForNextLevel:  " + levelSystem.xpForNextLevel.toString());

    return Container(
      height: 96.h,
      margin: EdgeInsets.symmetric(horizontal: 17.w, vertical: 17.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: AppStyle.decorationHome,
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
            value:
            '${AppFunction.getDistance(state.historyData.fold(0, (accumulator, element) => (accumulator + element.xp).toInt()) / 1000)} KM',
            label: 'Distance',
          ),
          _buildStatColumn(
            icon: Iconsax.heart_circle,
            iconColor: AppColors.dotColor,
            value: '${levelSystem.currentLevel} ',
            label: 'Level',
          ),
          IconButton(
            onPressed: () async {
              await showModalBottomSheet(
                context: Get.context,
                backgroundColor: AppColors.bgContainerColor,
                builder: (context1) => Container(
                  padding: EdgeInsets.all(12),
                  height: 300,
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppConst.addScore, style: AppStyle.textStyle21WhiteW700),
                        MyTextField(
                          controller: controller,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                        ),
                        MyMaterialButton(
                          title: AppConst.addScore,
                          onPressed: () {
                            Navigator.of(context1).pop();
                            context.read<HistoryDataBloc>().add(AddHistoryData(
                              HistoryDataModel(
                                id: Random().nextInt(1000000).toString(),
                                date: DateTime.now().toIso8601String(),

                                xp: int.tryParse(controller.text) ?? 0,
                              ),
                            ));
                          },
                          width: 326.w,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: Icon(Iconsax.add5, color: AppColors.white),
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
        SizedBox(height: 4.h),
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
