// data/services/history_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId;

  HistoryService() : userId = FirebaseAuth.instance.currentUser?.uid;

  Future<List<Map<String, dynamic>>> getHistoryData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      // Retrieve the history list from the user's document
      List<Map<String, dynamic>> history = userDoc.get('history') ?? [];
      return history;
    } catch (e) {
      print('Error getting history data: $e');
      return [];
    }
  }
  Future<void> setHistoryData(List<Map<String, dynamic>> historyData) async {
    try {
      WriteBatch batch = _firestore.batch();

      DocumentReference docRef = _firestore
          .collection('users')
          .doc(userId);


      batch.set(docRef, {"history":historyData}, SetOptions(merge: true));

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
