import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/dayliy_activity_card.dart';
import '../widgets/home_progress_level_steps_bar.dart';
import '../widgets/share_and_gift_.dart';
import '../widgets/total_point_and_steps.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // header have name and avatar and message button
        // HomeAppBar(),
        // progress bar , total steps and Level
        HomeProgressLevelStepsBar(),
        // daily activity points
        DailyActivityCard(),
        // Total point and steps
        TotalPointAndSteps(),
        // Gift image
        ShareAndGiftWidget(),
      ],
    );
  }
}
