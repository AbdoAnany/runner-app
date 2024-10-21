import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';



class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.isEmailVerified,
    super.displayName = null,
    super.photoUrl = null,
    super.role,

  }) ;
  factory UserModel.fromJson(  json) {
    print(json.data());
    return UserModel(
      id: json['userId'],
      email: json['email'],
      role: json['role'],
      photoUrl: json['photoUrl']??'',
      displayName: json['displayName']??'',
      isEmailVerified: json['isEmailVerified']??false,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'photoUrl': photoUrl,
      'isEmailVerified': isEmailVerified,
      'displayName': displayName,



    };
  }
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      email: user.email!,

      isEmailVerified: user.emailVerified,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }


}