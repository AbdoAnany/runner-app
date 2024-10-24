import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../3_home/data/models/user_data_model.dart';
import '../../../4_history/data/models/history_data_model.dart';

class UserPointControlService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? myUserId;

  UserPointControlService() : myUserId = FirebaseAuth.instance.currentUser?.uid;

  Future<List<Map<String, dynamic>>> getHistoryData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(myUserId).get();

      // Retrieve the history list from the user's document
      List<Map<String, dynamic>> history = List<Map<String, dynamic>>.from(userDoc.get('history') ?? []);
      print("history ===============");
      print(history);

      return history;
    } catch (e) {
      print('Error getting history data: $e');
      return [];
    }
  }

  Future<List<UserDataDataModel>> getAllUsersDataList() async {

    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    //
    // QuerySnapshot snapshot = await firestore.collection('users').get();
    // return snapshot.docs.map((doc) => User.fromDocument(doc)).toList();

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();

      // Retrieve the history list from the user's document
     return snapshot.docs.map((doc) => UserDataDataModel.fromJson2(doc)).toList();


      // return history;
    } catch (e) {
      print('Error getting history data: $e');
      return [];
    }
  }


  Future<bool> setUserPoints(PointUserHistoryDataModel historyData) async {
    try {
      WriteBatch batch = _firestore.batch();

      DocumentReference docRef = _firestore.collection('users').doc(historyData.userId);


      batch.set(docRef, {"history":historyData}, SetOptions(merge: true));



      await batch.commit();
      print('History data set successfully');
      return true;
    } catch (e) {
      print('Error setting history data: $e');
      return false;
    }
  }

  Future<bool> addHistoryEntry(Map<String, dynamic> entry) async {
    try {
      await _firestore.collection('users').doc(myUserId).update({
        'history': FieldValue.arrayUnion([entry])
      });

      print('History entry  ${entry} added successfully');

      return true;
    } catch (e) {
      print('Error adding history entry: $e');
      return false;
    }
  }

  Future<bool> updateHistoryEntry(String date, Map<String, dynamic> updates) async {
    try {
      var userDoc = await _firestore.collection('users').doc(myUserId).get();
      List<Map<String, dynamic>> history = List<Map<String, dynamic>>.from(userDoc.get('history') ?? []);

      // Find the entry to update
      int index = history.indexWhere((entry) => entry['date'] == date);
      if (index != -1) {
        history[index] = {...history[index], ...updates}; // Merge updates into the found entry

        await _firestore.collection('users').doc(myUserId).update({
          'history': history,
        });
return true;
        print('History entry updated successfully');
      } else {
        print('History entry not found');
        return false;
      }
    } catch (e) {
      print('Error updating history entry: $e');
      return false;
    }
  }

  Future<bool> deleteHistoryEntry(String date) async {
    try {
      var userDoc = await _firestore.collection('users').doc(myUserId).get();
      List<Map<String, dynamic>> history = List<Map<String, dynamic>>.from(userDoc.get('history') ?? []);
print(history.first);
print(history.length);
      // Remove the entry matching the given date
      history.removeWhere((entry) => entry['id'] == date);
      print(history.length);
      await _firestore.collection('users').doc(myUserId).update({
        'history': history,
      });

      print('History entry deleted successfully');
      return true;
    } catch (e) {
      print('Error deleting history entry: $e');
      return false;
    }
  }


}
