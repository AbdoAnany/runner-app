import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import 'home_progress_level_steps_bar.dart';

class HomeProgressLevelStepsBarTest extends StatelessWidget {
  final LevelSystem levelSystem;

  const HomeProgressLevelStepsBarTest({Key? key, required this.levelSystem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Level ${levelSystem.currentLevel}',
                        style: AppStyle.textStyle20GoldW800,
                      ),
                      const Spacer(),
                      Text(
                        '${NumberFormat("#,000").format(levelSystem.currentXP)} /',
                        style: AppStyle.textStyle12GrayW400,
                      ),
                      Text(
                        NumberFormat("#,000").format(levelSystem.xpForNextLevel),
                        style: AppStyle.textStyle20GWhiteW800,
                      ),
                      Text(
                        ' xp',
                        style: AppStyle.textStyle12GrayW400,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                      height: 10.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.white,
                      ),
                      child: CustomPaint(
                        painter: GradientProgressPainter(
                          progress: levelSystem.getXPProgress(),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.bar1HomeColor,
                              AppColors.levelHomeColor,
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
            width: 48.0,
            height: 48.0,
          ),
        ],
      ),
    );
  }
}


class GradientProgressPainter extends CustomPainter {
  final double progress;
  final Gradient gradient;

  GradientProgressPainter({required this.progress, required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = gradient.createShader(Offset.zero & size);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width * progress, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}