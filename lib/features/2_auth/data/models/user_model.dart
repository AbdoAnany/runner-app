import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';



// class UserDataDataModel extends UserEntity {
//   UserDataDataModel({
//     required super.id,
//     required super.email,
//     required super.isEmailVerified,
//     super.displayName = null,
//     super.photoUrl = null,
//     super.role,
//
//   }) ;
//   factory UserDataDataModel.fromJson(  json) {
//     print(json.data());
//     return UserDataDataModel(
//       id: json['userId'],
//       email: json['email'],
//       role: json['role'],
//       photoUrl: json['photoUrl']??'',
//       displayName: json['displayName']??'',
//       isEmailVerified: json['isEmailVerified']??false,
//     );
//   }
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'email': email,
//       'role': role,
//       'photoUrl': photoUrl,
//       'isEmailVerified': isEmailVerified,
//       'displayName': displayName,
//
//
//
//     };
//   }
//   factory UserDataDataModel.fromFirebaseUser(User user) {
//     return UserDataDataModel(
//       id: user.uid,
//       email: user.email!,
//
//       isEmailVerified: user.emailVerified,
//       displayName: user.displayName,
//       photoUrl: user.photoURL,
//     );
//   }
//
//
// }