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
      Map<String, dynamic> userData = userDoc.get('UserData');
      print("UserData ===============");
      print(userData);

      return userData;
    } catch (e) {
      print('Error getting UserData data: $e');
      return null;
    }
  }

  Future<void> setUserDataData(Map<String, dynamic> userData) async {
    try {
      WriteBatch batch = _firestore.batch();

      DocumentReference docRef = _firestore.collection('users').doc(userId);

      batch.set(docRef, {"UserData": userData}, SetOptions(merge: true));

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
          .update({'UserData': entry});

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
        'UserData': updates,
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
          List<Map<String, dynamic>>.from(userDoc.get('UserData') ?? []);

      // Remove the entry matching the given date
      userData.removeWhere((entry) => entry['id'] == date);
      await _firestore.collection('users').doc(userId).update({
        'UserData': userData,
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
        'UserData': updates,
      });
      return true;
    } catch (e) {
      print('Error updating UserData entry: $e');
      return false;
    }
  }
}
