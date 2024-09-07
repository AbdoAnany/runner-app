// domain/entities/user_data_entity.dart

// data/models/user_data_model.dart

import '../../domain/entities/user_data_entity.dart';

import '../../domain/entities/user_data_entity.dart';

class UserDataDataModel extends UserDataEntity {
  UserDataDataModel({
    required super.userId,
    required super.date,
    required super.activeNumber,
    required super.name,
    required super.email,
    required super.roles,
    required super.adminId,
    required super.currentLevel,
    required super.currentXP,
    required super.userState,
    required super.xpForNextLevel,
    required super.xpProgress,
  });

  factory UserDataDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataDataModel(
      userId: map['userId'],
      name: map['name'],
      email: map['email'],
      roles: map['roles'],
      date: map['date'],
      activeNumber: map['activeNumber'],
      adminId: map['adminId'],
      currentLevel: map['currentLevel'],
      currentXP: map['currentXP'],
      userState: map['userState'],
      xpForNextLevel: map['xpForNextLevel'],
      xpProgress: map['xpProgress'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': date,
      'name': name,
      'email': email,
      'roles': roles,
      'activeNumber': activeNumber,
      'adminId': adminId,
      'currentLevel': currentLevel,
      'currentXP': currentXP,
      'userState': userState,
      'xpForNextLevel': xpForNextLevel,
      'xpProgress': xpProgress,
    };
  }

  UserDataDataModel copyWith({
    String? userId,
    String? date,
    int? activeNumber,
    String? name,
    String? email,
    String? roles,
    String? adminId,
    int? currentLevel,
    int? currentXP,
    String? userState,
    int? xpForNextLevel,
    double? xpProgress,
  }) {
    return UserDataDataModel(
      userId: userId ?? this.userId,
      date: date ?? this.date,
      activeNumber: activeNumber ?? this.activeNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      roles: roles ?? this.roles,
      adminId: adminId ?? this.adminId,
      currentLevel: currentLevel ?? this.currentLevel,
      currentXP: currentXP ?? this.currentXP,
      userState: userState ?? this.userState,
      xpForNextLevel: xpForNextLevel ?? this.xpForNextLevel, xpProgress: 0,
    );
  }
}