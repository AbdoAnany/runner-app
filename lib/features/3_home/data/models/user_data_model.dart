// domain/entities/user_data_entity.dart

// data/models/user_data_model.dart

import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_data_entity.dart';

class UserDataDataModel extends UserDataEntity {
  UserDataDataModel({
    required super.userId,
    required super.fcmToken,
     super.date="",
     super.rank="D",
     super.activeNumber=0,
     super.name="",
     super.email="",
     super.roles='user',
     super.adminId="",
     super.photoUrl="",
     super.phone="",
     super.currentLevel=1,
     super.currentXP=1,
     super.userState="",
     super.xpForNextLevel=0,
     super.xpProgress=1,
  });

  factory UserDataDataModel.fromJson(Map<String, dynamic> map) {
    return UserDataDataModel(
      userId: map['userId'],
      fcmToken: map['fcmToken'],
      name: map['name'],
      rank: map['rank']??"D",
      email: map['email'],
      roles: map['roles'],
      date: map['date'],
      activeNumber: map['activeNumber'],
      adminId: map['adminId'],
      photoUrl: map['photoUrl']??'',
      phone: map['phone'],
      currentLevel: map['currentLevel'],
      currentXP: map['currentXP'],
      userState: map['userState'],
      xpForNextLevel: map['xpForNextLevel'],
      xpProgress: map['xpProgress'],
    );
  }
  factory UserDataDataModel.fromJson2( json) {
   final map=json['userData'];
    return UserDataDataModel(
      userId: map['userId'],
      fcmToken: map['fcmToken'],
      name: map['name'],
      rank: map['rank']??"D",
      email: map['email'],
      roles: map['roles'],
      date: map['date'],
      activeNumber: map['activeNumber'],
      adminId: map['adminId'],
      photoUrl: map['photoUrl']??'',
      phone: map['phone'],
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
      'fcmToken': fcmToken,
      'date': date,
      'name': name,
      'rank': rank,
      'email': email,
      'roles': roles,
      'activeNumber': activeNumber,
      'adminId': adminId,
      'phone': phone??"",
      'photoUrl': photoUrl??"",
      'currentLevel': currentLevel,
      'currentXP': currentXP,
      'userState': userState,
      'xpForNextLevel': xpForNextLevel,
      'xpProgress': xpProgress,
    };
  }
  factory UserDataDataModel.fromFirebaseUser(User user) {
    return UserDataDataModel(
      userId: user.uid,
      email: user.email!,
      fcmToken:"",


      name: user.displayName??'',
      photoUrl: user.photoURL, date: '', roles: '',
    );
  }
  UserDataDataModel copyWith({
    String? userId,
    String? date,
    int? activeNumber,
    String? name,
    String? email,
    String? rank,
    String? roles,
    String? adminId,
    String? phone,
    int? currentLevel,
    int? currentXP,
    String? userState,
    int? xpForNextLevel,
    double? xpProgress,
  }) {
    return UserDataDataModel(
      userId: userId ?? this.userId,
      fcmToken: fcmToken ?? this.fcmToken,
      date: date ?? this.date,
      activeNumber: activeNumber ?? this.activeNumber,
      name: name ?? this.name,
      rank: rank ?? this.rank,
      email: email ?? this.email,
      roles: roles ?? this.roles,
      adminId: adminId ?? this.adminId,
      phone: phone ?? this.phone,
      currentLevel: currentLevel ?? this.currentLevel,
      currentXP: currentXP ?? this.currentXP,
      userState: userState ?? this.userState,
      xpForNextLevel: xpForNextLevel ?? this.xpForNextLevel, xpProgress: 0,
    );
  }
}