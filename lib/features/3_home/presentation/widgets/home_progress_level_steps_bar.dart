import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../7_level_gallary/presentation/widgets/LevelSeverGen.dart';
import 'gradient_Progress_painter.dart';



class HomeProgressLevelStepsBar extends StatefulWidget {
  const HomeProgressLevelStepsBar({super.key, required this.levelSystem});
  final LevelSystem levelSystem;

  @override
  State<HomeProgressLevelStepsBar> createState() => _HomeProgressLevelStepsBarState();
}

class _HomeProgressLevelStepsBarState extends State<HomeProgressLevelStepsBar> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _flashAnimationController;
  late AnimationController _scaleAnimationController;
  late Animation<double> _progressAnimation;
  late Animation<int> _xpAnimation;
  late Animation<int> _levelAnimation;
  late Animation<int> _xpForNextLevelAnimation;
  late Animation<double> _badgeScaleAnimation;
  late Animation<double> _flashAnimation;
  late Animation<double> _barScaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _flashAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
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

    _badgeScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _flashAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _flashAnimationController,
      curve: Curves.easeInOut,
    ));

    _barScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _scaleAnimationController,
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
      // Add a pause
      progressSequence.add(TweenSequenceItem(
        tween: ConstantTween<double>(isLevelUp ? 1.0 : 0.0),
        weight: 0.5,
      ));
      if (!isLastIteration) {
        progressSequence.add(TweenSequenceItem(
          tween: Tween<double>(begin: isLevelUp ? 0.0 : 1.0, end: isLevelUp ? 0.0 : 1.0),
          weight: 2,
        ));
      } else {
        progressSequence.add(TweenSequenceItem(
          tween: Tween<double>(begin: isLevelUp ? 0.0 : 1.0, end: widget.levelSystem.getXPProgress()),
          weight: 2,
        ));
      }

      // Level animation
      levelSequence.add(TweenSequenceItem(
        tween: IntTween(begin: startLevel, end: startLevel),
        weight: 1,
      ));
      levelSequence.add(TweenSequenceItem(
        tween: IntTween(begin: startLevel, end: nextLevel),
        weight: 2.5,
      ));

      // XP animation
      final nextXP = isLastIteration ? widget.levelSystem.currentXP : (isLevelUp ? startXPForNextLevel : 0);
      xpSequence.add(TweenSequenceItem(
        tween: IntTween(begin: startXP, end: nextXP),
        weight: 3,
      ));

      // XP for next level animation
      final nextXPForNextLevel = isLastIteration
          ? widget.levelSystem.xpForNextLevel
          : (isLevelUp
          ? widget.levelSystem.getXPForLevel(nextLevel + 1)
          : oldWidget.levelSystem.getXPForLevel(nextLevel));
      xpForNextLevelSequence.add(TweenSequenceItem(
        tween: IntTween(begin: startXPForNextLevel, end: nextXPForNextLevel),
        weight: 3,
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
    _animationController.duration = Duration(milliseconds: 2000 * absLevelDifference);

    // Set up a listener to trigger flash effect and scale animation at level changes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        _flashAnimationController.repeat(reverse: true);
        _scaleAnimationController.repeat(reverse: true);
      } else if (status == AnimationStatus.completed) {
        _flashAnimationController.stop();
        _flashAnimationController.value = 0.0;
        _scaleAnimationController.stop();
        _scaleAnimationController.value = 1.0;
      }
    });
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

    _animationController.duration = const Duration(milliseconds: 2000);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _flashAnimationController.dispose();
    _scaleAnimationController.dispose();
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
                          return AnimatedBuilder(
                            animation: _flashAnimation,
                            builder: (context, child) {
                              return Text(
                                'Level ${_levelAnimation.value}',
                                style: AppStyle.textStyle20GoldW800.copyWith(
                                  color: Color.lerp(
                                    AppStyle.textStyle20GoldW800.color,
                                    Colors.white,
                                    _flashAnimation.value,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const Spacer(),
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
                    ],
                  ),
                  SizedBox(height: 2.h),
                  AnimatedBuilder(
                    animation: _barScaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _barScaleAnimation.value,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Container(
                            height: 10.0.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: _progressAnimation.value > 0.9 ? Colors.yellowAccent : Colors.transparent,
                                  spreadRadius: 2,
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
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
                                        AppColors.levelHomeColor,
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _badgeScaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _badgeScaleAnimation.value,
                child:     LevelSeverGen(index:_levelAnimation.value ,),
              );
            },
          ),
        ],
      ),
    );
  }
}

class LevelSystem {
  late int currentLevel;
  late int currentXP;
  late int xpForNextLevel;
  final double baseXP;
  final double growthFactor;

  LevelSystem({
    this.currentLevel = 1,
    this.currentXP = 0,
    this.baseXP = 100,
    this.growthFactor = 1.5,
  }) {
    xpForNextLevel = getXPForLevel(currentLevel + 1);
  }

  int getXPForLevel(int level) {
    return (baseXP * pow(level, growthFactor)).toInt();
  }

  void addXP(int xp) {
    currentXP += xp;
    while (currentXP >= xpForNextLevel) {
      levelUp();
    }
  }

  void levelUp() {
    currentLevel++;
    currentXP -= xpForNextLevel;
    xpForNextLevel = getXPForLevel(currentLevel + 1);
  }

  double getXPProgress() {
    return currentXP / xpForNextLevel;
  }

  int getXPForCurrentLevel() {
    return xpForNextLevel.floor();
  }

  Map<String, dynamic> toJson() {
    return {
      'currentLevel': currentLevel,
      'currentXP': currentXP,
      'xpForNextLevel': xpForNextLevel,

    };
  }

  factory LevelSystem.fromJson(Map<String, dynamic> json) {
    return LevelSystem(
      currentLevel: json['currentLevel'],
      currentXP: json['currentXP'],
    );
  }
}