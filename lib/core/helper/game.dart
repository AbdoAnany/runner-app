import 'dart:math';

// class Player {
//  late int level;
//  late double currentXP;
//   late double xpForNextLevel;
//
//   Player({
//     this.level = 1,
//     this.currentXP = 0,
//   }) {
//     xpForNextLevel = calculateXPForLevel(level + 1);
//   }
//
//   double calculateXPForLevel(int level) {
//     const baseXP = 100.0;
//     const scale = 1.5;
//     return baseXP * pow(level, scale);
//   }
//
//   void gainXP(double xpEarned) {
//     currentXP += xpEarned;
//     print('Gained $xpEarned XP, Total XP: $currentXP');
//     while (currentXP >= xpForNextLevel) {
//       levelUp();
//     }
//   }
//
//   void levelUp() {
//     level++;
//     currentXP -= xpForNextLevel;
//     xpForNextLevel = calculateXPForLevel(level + 1);
//     print('Level Up! New level: $level, XP for next level: $xpForNextLevel');
//   }
// }


class LevelSystem {
 late int currentLevel;
 late double currentXP;
 late double xpForNextLevel;
  final double baseXP;
  final double growthFactor;

  LevelSystem({
    this.currentLevel = 1,
    this.currentXP = 0,
    this.baseXP = 100,
    this.growthFactor = 1.5,
  }) {
    xpForNextLevel = calculateXPForLevel(currentLevel + 1);
  }

  double calculateXPForLevel(int level) {
    return baseXP * pow(level, growthFactor);
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
    xpForNextLevel = calculateXPForLevel(currentLevel + 1);
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