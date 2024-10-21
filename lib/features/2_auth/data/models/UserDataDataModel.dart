// Note: Ensure you have the UserDataDataModel class defined somewhere in your project
import 'dart:convert';

class UserDataDataModel {
  final String userId;
  final String date;
  final int activeNumber;
  final String name;
  final String rank;
  final String email;
  final String phone;
  final String roles;
  final String adminId;
  final int currentLevel;
  final int currentXP;
  final String userState;
  final int xpForNextLevel;
  final int xpProgress;

  UserDataDataModel({
    required this.userId,
    required this.date,
    required this.activeNumber,
    required this.name,
    required this.rank,
    required this.email,
    required this.phone,
    required this.roles,
    required this.adminId,
    required this.currentLevel,
    required this.currentXP,
    required this.userState,
    required this.xpForNextLevel,
    required this.xpProgress,
  });
  factory UserDataDataModel.fromJson(json) {
    json=json['userData'];
    return UserDataDataModel(
      userId: json['userId'],
      date: json['date'],
      activeNumber: json['activeNumber'],
      name: json['name'],
      rank: json['rank'],
      email: json['email'],
      phone: json['phone'],
      roles: json['roles'],
      adminId: json['adminId'],
      currentLevel: json['currentLevel'],
      currentXP: json['currentXP'],
      userState: json['userState'],
      xpForNextLevel: json['xpForNextLevel'],
      xpProgress: json['xpProgress'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': date,
      'activeNumber': activeNumber,
      'name': name,
      'rank': rank,
      'email': email,
      'phone': phone,
      'roles': roles,
      'adminId': adminId,
      'currentLevel': currentLevel,
      'currentXP': currentXP,
      'userState': userState,
      'xpForNextLevel': xpForNextLevel,
      'xpProgress': xpProgress,
    };
  }
}