import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/const/const.dart';
import '../../../../core/helper/game.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import 'gradient_Progress_painter.dart';

class HomeProgressLevelStepsBar extends StatefulWidget {
  const HomeProgressLevelStepsBar({super.key, required this.levelSystem});
  final LevelSystem levelSystem;

  @override
  State<HomeProgressLevelStepsBar> createState() => _HomeProgressLevelStepsBarState();
}

class _HomeProgressLevelStepsBarState extends State<HomeProgressLevelStepsBar> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  late Animation<int> _xpAnimation;
  late Animation<int> _levelAnimation;
  late Animation<int> _xpForNextLevelAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _initializeAnimations();
    _animationController.forward();
  }

  void _initializeAnimations() {
    _progressAnimation = Tween<double>(
      begin: 0,
      end: widget.levelSystem.getXPProgress(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _xpAnimation = IntTween(
      begin: 0,
      end: widget.levelSystem.currentXP,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _levelAnimation = IntTween(
      begin: widget.levelSystem.currentLevel,
      end: widget.levelSystem.currentLevel,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _xpForNextLevelAnimation = IntTween(
      begin: widget.levelSystem.xpForNextLevel,
      end: widget.levelSystem.xpForNextLevel,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(HomeProgressLevelStepsBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.levelSystem != widget.levelSystem) {
      final levelDifference = widget.levelSystem.currentLevel - oldWidget.levelSystem.currentLevel;

      if (levelDifference != 0) {
        _animateLevelChange(oldWidget, levelDifference);
      } else {
        _updateAnimations(oldWidget.levelSystem.getXPProgress(), widget.levelSystem.getXPProgress());
      }

      _animationController.forward(from: 0);
    }
  }

  void _animateLevelChange(HomeProgressLevelStepsBar oldWidget, int levelDifference) {
    final isLevelUp = levelDifference > 0;
    final absLevelDifference = levelDifference.abs();

    List<TweenSequenceItem<double>> progressSequence = [];
    List<TweenSequenceItem<int>> levelSequence = [];
    List<TweenSequenceItem<int>> xpSequence = [];
    List<TweenSequenceItem<int>> xpForNextLevelSequence = [];

    double startProgress = oldWidget.levelSystem.getXPProgress();
    int startXP = oldWidget.levelSystem.currentXP;
    int startLevel = oldWidget.levelSystem.currentLevel;
    int startXPForNextLevel = oldWidget.levelSystem.xpForNextLevel;

    for (int i = 0; i < absLevelDifference; i++) {
      final isLastIteration = i == absLevelDifference - 1;
      final endProgress = isLastIteration ? widget.levelSystem.getXPProgress() : (isLevelUp ? 1.0 : 0.0);
      final nextLevel = isLevelUp ? startLevel + 1 : startLevel - 1;

      // Progress animation
      progressSequence.add(TweenSequenceItem(
        tween: Tween<double>(begin: startProgress, end: isLevelUp ? 1.0 : 0.0),
        weight: 1,
      ));
      if (!isLastIteration) {
        progressSequence.add(TweenSequenceItem(
          tween: Tween<double>(begin: isLevelUp ? 0.0 : 1.0, end: endProgress),
          weight: 1,
        ));
      }

      // Level animation
      levelSequence.add(TweenSequenceItem(
        tween: IntTween(begin: startLevel, end: nextLevel),
        weight: 2,
      ));

      // XP animation
      final nextXP = isLastIteration ? widget.levelSystem.currentXP : (isLevelUp ? startXPForNextLevel : 0);
      xpSequence.add(TweenSequenceItem(
        tween: IntTween(begin: startXP, end: nextXP),
        weight: 2,
      ));

      // XP for next level animation
      final nextXPForNextLevel = isLastIteration ? widget.levelSystem.xpForNextLevel : (isLevelUp ? widget.levelSystem.getXPForLevel(nextLevel + 1) : oldWidget.levelSystem.getXPForLevel(nextLevel));
      xpForNextLevelSequence.add(TweenSequenceItem(
        tween: IntTween(begin: startXPForNextLevel, end: nextXPForNextLevel),
        weight: 2,
      ));

      startProgress = isLevelUp ? 0.0 : 1.0;
      startXP = nextXP;
      startLevel = nextLevel;
      startXPForNextLevel = nextXPForNextLevel;
    }

    _progressAnimation = TweenSequence<double>(progressSequence).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _levelAnimation = TweenSequence<int>(levelSequence).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _xpAnimation = TweenSequence<int>(xpSequence).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _xpForNextLevelAnimation = TweenSequence<int>(xpForNextLevelSequence).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Adjust animation duration based on the number of level changes
    _animationController.duration = Duration(milliseconds: 1500 * absLevelDifference);
  }

  void _updateAnimations(double oldProgress, double newProgress) {
    _progressAnimation = Tween<double>(
      begin: oldProgress,
      end: newProgress,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _xpAnimation = IntTween(
      begin: _xpAnimation.value,
      end: widget.levelSystem.currentXP,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _xpForNextLevelAnimation = IntTween(
      begin: _xpForNextLevelAnimation.value,
      end: widget.levelSystem.xpForNextLevel,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.duration = const Duration(milliseconds: 1500);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0.h,
      margin: EdgeInsets.only(left: 10.0.w, right: 10.0.w, bottom: 0.0.h),
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
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Text(
                            '${NumberFormat("#,000").format(_xpAnimation.value)} /',
                            style: AppStyle.textStyle12GrayW400,
                          );
                        },
                      ),
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Text(
                            NumberFormat("#,000").format(_xpForNextLevelAnimation.value),
                            style: AppStyle.textStyle20GWhiteW800,
                          );
                        },
                      ),
                      Text(
                        ' xp',
                        style: AppStyle.textStyle12GrayW400,
                      ),
                      const Spacer(),
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Text(
                            'Level ${_levelAnimation.value}',
                            style: AppStyle.textStyle20GoldW800,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                      height: 10.0.h,
                      width: double.infinity,
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
                      child: AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: GradientProgressPainter(
                              progress: _progressAnimation.value,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.bar1HomeColor,
                                  AppColors.bar2HomeColor,
                                ],
                              ),
                            ),
                          );
                        },
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