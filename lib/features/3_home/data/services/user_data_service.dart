// data/services/user_data_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:runner_app/core/errors/failure.dart';
import 'package:runner_app/core/notification_service/TokenMonitor.dart';
import 'package:runner_app/features/3_home/data/models/user_data_model.dart';
import 'package:rxdart/rxdart.dart';

class UserDataService1 {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId;

  UserDataService1() : userId = FirebaseAuth.instance.currentUser?.uid;

  Future<Map<String, dynamic>?> getUserDataData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Retrieve the history list from the user's document
      Map<String, dynamic> userData = userDoc.get('userData');
      print("UserData ===============");
      final fcmTocken = await FirebaseMessaging.instance.getToken();
      print(fcmTocken);

      return userData;
    } catch (e) {
      // if (e=="Bad state: cannot get field \"userData\" on a DocumentSnapshotPlatform which does not exist") {
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      await setUserDataData({
        "date": DateTime.now().toIso8601String(),
        "currentXP": 1,
        'fcmToken': TokenMonitor.token,

        "roles": "user",
        "xpForNextLevel": 100,
        "xpProgress": 1,
        "userId": FirebaseAuth.instance.currentUser?.uid,
        "currentLevel": 1,
        "phone": FirebaseAuth.instance.currentUser?.phoneNumber ?? '',
        "userState": "active",
        "activeNumber": 0,
        "adminId": "",
        "name": FirebaseAuth.instance.currentUser?.displayName ?? '',
        "rank": "D",
        "email": FirebaseAuth.instance.currentUser?.email ?? ''
      });
      await getUserDataData();
      // }

      print('Error getting UserData data: $e');
      return null;
    }
  }

  Future<void> setUserDataData(Map<String, dynamic> userData) async {
    try {
      WriteBatch batch = _firestore.batch();

      DocumentReference docRef = _firestore.collection('users').doc(userId);

      batch.set(docRef, {"userData": userData}, SetOptions(merge: true));

      await batch.commit();
      print('UserData data set successfully');
    } catch (e) {
      print('Error setting UserData data: $e');
    }
  }

  Future<bool> addUserDataEntry(Map<String, dynamic> entry) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({'userData': entry});

      print('UserData entry  ${entry} added successfully');

      return true;
    } catch (e) {
      print('Error adding UserData entry: $e');
      return false;
    }
  }

  Future<Result<bool>> updateUserDataEntry(
      {required Map<String, dynamic> updates, required String userId}) async {
    try {
      // var userDoc = await _firestore.collection('users').doc(userId).get();
      // Map<String, dynamic> userData = userDoc.get('UserData');
      await _firestore.collection('users').doc(userId).update({
        'userData': updates,
      });
      return Result(const Right(true));
    } catch (e) {
      print('Error updating UserData entry: $e');
      return Result(Left(ServerFailure(e.toString())));
    }
  }

  Future<bool> deleteUserDataEntry(String date) async {
    try {
      var userDoc = await _firestore.collection('users').doc(userId).get();
      List<Map<String, dynamic>> userData =
          List<Map<String, dynamic>>.from(userDoc.get('userData') ?? []);

      // Remove the entry matching the given date
      userData.removeWhere((entry) => entry['id'] == date);
      await _firestore.collection('users').doc(userId).update({
        'userData': userData,
      });

      print('UserData entry deleted successfully');
      return true;
    } catch (e) {
      print('Error deleting UserData entry: $e');
      return false;
    }
  }

  updateLevelData(Map<String, dynamic> updates) async {
    try {
      // var userDoc = await _firestore.collection('users').doc(userId).get();
      // Map<String, dynamic> userData = userDoc.get('UserData');
      await _firestore.collection('users').doc(userId).update({
        'userData': updates,
      });
      return true;
    } catch (e) {
      print('Error updating UserData entry: $e');
      return false;
    }
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:rxdart/subjects.dart';

class UserDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final BehaviorSubject<Map<String, dynamic>> _userDataController = BehaviorSubject<Map<String, dynamic>>();

  // Stream getter for real-time updates
  Stream<Map<String, dynamic>> get userDataStream => _userDataController.stream;

  // Get current user's ID
  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

  // Get user document reference
  DocumentReference getUserRef(String userId) => _firestore.collection('users').doc(userId);

  // Create or get user data
  Future<Map<String, dynamic>?> getUserData({String? userId}) async {
    try {
      final targetUserId = userId ?? currentUserId;
      if (targetUserId == null) return null;

      DocumentSnapshot userDoc = await getUserRef(targetUserId).get();

      if (!userDoc.exists || !userDoc.data().toString().contains('userData')) {
        // Create default user data if it doesn't exist
        final defaultData = await _createDefaultUserData(targetUserId);
        return defaultData;
      }

      Map<String, dynamic> userData = userDoc.get('userData');
      _userDataController.add(userData); // Update stream
      return userData;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  // Create default user data
  Future<Map<String, dynamic>> _createDefaultUserData(String userId) async {
    final user = userId == currentUserId
        ? FirebaseAuth.instance.currentUser
        : null;

    final defaultData = {
      "date": DateTime.now().toIso8601String(),
      "currentXP": 1,
      'fcmToken': await _getFCMToken(),
      "roles": "user",
      "xpForNextLevel": 100,
      "xpProgress": 1,
      "userId": userId,
      "currentLevel": 1,
      "phone": user?.phoneNumber ?? '',
      "userState": "active",
      "activeNumber": 0,
      "adminId": "",
      "name": user?.displayName ?? '',
      "rank": "D",
      "email": user?.email ?? ''
    };

    await setUserData(defaultData, userId: userId);
    return defaultData;
  }

  // Get FCM token
  Future<String> _getFCMToken() async {
    try {
      return await FirebaseMessaging.instance.getToken() ?? '';
    } catch (e) {
      print('Error getting FCM token: $e');
      return '';
    }
  }

  // Set complete user data
  Future<bool> setUserData(Map<String, dynamic> userData, {String? userId}) async {
    try {
      final targetUserId = userId ?? currentUserId;
      if (targetUserId == null) return false;

      WriteBatch batch = _firestore.batch();
      DocumentReference docRef = getUserRef(targetUserId);

      batch.set(docRef, {"userData": userData}, SetOptions(merge: true));
      await batch.commit();

      _userDataController.add(userData); // Update stream
      print('User data set successfully for user: $targetUserId');
      return true;
    } catch (e) {
      print('Error setting user data: $e');
      return false;
    }
  }

  // Update specific fields in user data
  Future<bool> updateUserFields({
    required Map<String, dynamic> updates,
    required String userId,
  }) async {
    try {
      await getUserRef(userId).update({
        'userData': updates,
      });

      if (userId == currentUserId) {
        _userDataController.add(updates); // Update stream for current user
      }

      print('User fields updated successfully for user: $userId');
      return true;
    } catch (e) {
      print('Error updating user fields: $e');
      return false;
    }
  }

  // Update level data
  Future<bool> updateLevelData(Map<String, dynamic> updates, {String? userId}) async {
    try {
      final targetUserId = userId ?? currentUserId;
      if (targetUserId == null) return false;

      await getUserRef(targetUserId).update({
        'userData': updates,
      });

      if (targetUserId == currentUserId) {
        _userDataController.add(updates); // Update stream for current user
      }

      print('Level data updated successfully for user: $targetUserId');
      return true;
    } catch (e) {
      print('Error updating level data: $e');
      return false;
    }
  }

  // Increment specific numeric fields
  Future<bool> incrementFields({
    required Map<String, num> increments,
    required String userId,
  }) async {
    try {
      final docRef = getUserRef(userId);

      // Get current data first
      DocumentSnapshot doc = await docRef.get();
      Map<String, dynamic> currentData = doc.get('userData');

      // Apply increments
      increments.forEach((key, value) {
        if (currentData.containsKey(key) && currentData[key] is num) {
          currentData[key] = (currentData[key] as num) + value;
        }
      });

      // Update the document
      await docRef.update({
        'userData': currentData,
      });

      if (userId == currentUserId) {
        _userDataController.add(currentData); // Update stream for current user
      }

      return true;
    } catch (e) {
      print('Error incrementing fields: $e');
      return false;
    }
  }

  // Delete user data
  Future<bool> deleteUserData(String userId) async {
    try {
      await getUserRef(userId).delete();

      if (userId == currentUserId) {
        _userDataController.add({}); // Clear stream for current user
      }

      print('User data deleted successfully for user: $userId');
      return true;
    } catch (e) {
      print('Error deleting user data: $e');
      return false;
    }
  }

  // Listen to real-time updates for a specific user
  Stream<Map<String, dynamic>?> listenToUserData(String userId) {
    return getUserRef(userId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return doc.get('userData');
    });
  }

  // Check if user exists
  Future<bool> userExists(String userId) async {
    try {
      DocumentSnapshot doc = await getUserRef(userId).get();
      return doc.exists;
    } catch (e) {
      print('Error checking user existence: $e');
      return false;
    }
  }

  // Clean up resources
  void dispose() {
    _userDataController.close();
  }
}
// // user_model.dart
// class UserData {
//   final String id;
//   final DateTime date;
//   final int currentXP;
//   final String fcmToken;
//   final String roles;
//   final int xpForNextLevel;
//   final int xpProgress;
//   final String userId;
//   final int currentLevel;
//   final String phone;
//   final String userState;
//   final int activeNumber;
//   final String adminId;
//   final String name;
//   final String rank;
//   final String email;
//
//   UserData({
//     required this.id,
//     required this.date,
//     required this.currentXP,
//     required this.fcmToken,
//     required this.roles,
//     required this.xpForNextLevel,
//     required this.xpProgress,
//     required this.userId,
//     required this.currentLevel,
//     required this.phone,
//     required this.userState,
//     required this.activeNumber,
//     required this.adminId,
//     required this.name,
//     required this.rank,
//     required this.email,
//   });
//
//   factory UserData.fromJson(Map<String, dynamic> json) {
//     return UserData(
//       id: json['id'] ?? '',
//       date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
//       currentXP: json['currentXP'] ?? 1,
//       fcmToken: json['fcmToken'] ?? '',
//       roles: json['roles'] ?? 'user',
//       xpForNextLevel: json['xpForNextLevel'] ?? 100,
//       xpProgress: json['xpProgress'] ?? 1,
//       userId: json['userId'] ?? '',
//       currentLevel: json['currentLevel'] ?? 1,
//       phone: json['phone'] ?? '',
//       userState: json['userState'] ?? 'active',
//       activeNumber: json['activeNumber'] ?? 0,
//       adminId: json['adminId'] ?? '',
//       name: json['name'] ?? '',
//       rank: json['rank'] ?? 'D',
//       email: json['email'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'date': date.toIso8601String(),
//       'currentXP': currentXP,
//       'fcmToken': fcmToken,
//       'roles': roles,
//       'xpForNextLevel': xpForNextLevel,
//       'xpProgress': xpProgress,
//       'userId': userId,
//       'currentLevel': currentLevel,
//       'phone': phone,
//       'userState': userState,
//       'activeNumber': activeNumber,
//       'adminId': adminId,
//       'name': name,
//       'rank': rank,
//       'email': email,
//     };
//   }
//
//   UserData copyWith({
//     String? id,
//     DateTime? date,
//     int? currentXP,
//     String? fcmToken,
//     String? roles,
//     int? xpForNextLevel,
//     int? xpProgress,
//     String? userId,
//     int? currentLevel,
//     String? phone,
//     String? userState,
//     int? activeNumber,
//     String? adminId,
//     String? name,
//     String? rank,
//     String? email,
//   }) {
//     return UserData(
//       id: id ?? this.id,
//       date: date ?? this.date,
//       currentXP: currentXP ?? this.currentXP,
//       fcmToken: fcmToken ?? this.fcmToken,
//       roles: roles ?? this.roles,
//       xpForNextLevel: xpForNextLevel ?? this.xpForNextLevel,
//       xpProgress: xpProgress ?? this.xpProgress,
//       userId: userId ?? this.userId,
//       currentLevel: currentLevel ?? this.currentLevel,
//       phone: phone ?? this.phone,
//       userState: userState ?? this.userState,
//       activeNumber: activeNumber ?? this.activeNumber,
//       adminId: adminId ?? this.adminId,
//       name: name ?? this.name,
//       rank: rank ?? this.rank,
//       email: email ?? this.email,
//     );
//   }
// }

// user_data_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:rxdart/rxdart.dart';

