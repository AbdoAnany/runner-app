// data/services/user_data_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId;

  UserDataService() : userId = FirebaseAuth.instance.currentUser?.uid;

  Future<Map<String, dynamic>?> getUserDataData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Retrieve the history list from the user's document
      Map<String, dynamic> userData = userDoc.get('userData');
      print("UserData ===============");
      print(userData);

      return userData;
    } catch (e) {
      // if (e=="Bad state: cannot get field \"userData\" on a DocumentSnapshotPlatform which does not exist") {
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      await setUserDataData({
        "date": DateTime.now().toIso8601String(),
        "currentXP": 1,
        "roles": "user",
        "xpForNextLevel": 100,
        "xpProgress": 1,
        "userId": FirebaseAuth.instance.currentUser?.uid,
        "currentLevel": 1,
        "phone":FirebaseAuth.instance.currentUser?.phoneNumber??'',
        "userState": "active",
        "activeNumber": 0,
        "adminId": "",
        "name": FirebaseAuth.instance.currentUser?.displayName??'',
        "rank": "D",
        "email": FirebaseAuth.instance.currentUser?.email??''
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

  Future<bool> updateUserDataEntry(Map<String, dynamic> updates) async {
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
