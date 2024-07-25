// data/services/history_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId;

  HistoryService() : userId = FirebaseAuth.instance.currentUser?.uid;

  Future<List<Map<String, dynamic>>> getHistoryData() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('history')
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error getting history data: $e');
      return [];
    }
  }

  Future<void> setHistoryData(List<Map<String, dynamic>> historyData) async {
    try {
      WriteBatch batch = _firestore.batch();

      for (var data in historyData) {
        DocumentReference docRef = _firestore
            .collection('users')
            .doc(userId)
            .collection('history')
            .doc(data['date']);

        batch.set(docRef, data, SetOptions(merge: true));
      }

      await batch.commit();
      print('History data set successfully');
    } catch (e) {
      print('Error setting history data: $e');
    }
  }

  Future<void> addHistoryEntry(Map<String, dynamic> entry) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('history')
          .doc(entry['date'])
          .set(entry, SetOptions(merge: true));

      print('History entry added successfully');
    } catch (e) {
      print('Error adding history entry: $e');
    }
  }

  Future<void> updateHistoryEntry(String date, Map<String, dynamic> updates) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('history')
          .doc(date)
          .update(updates);

      print('History entry updated successfully');
    } catch (e) {
      print('Error updating history entry: $e');
    }
  }

  Future<void> deleteHistoryEntry(String date) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('history')
          .doc(date)
          .delete();

      print('History entry deleted successfully');
    } catch (e) {
      print('Error deleting history entry: $e');
    }
  }
}
