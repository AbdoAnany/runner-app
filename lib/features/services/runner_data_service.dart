import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


List historyData = [
  {'date': '2024-01-01',
    "kal":512,
    "steps": 114141,
    "pt": 0,
    "distance": 1000.0,  },

  {'date': '2024-01-02',
    "kal":512,
    "steps": 7447,
    "pt": 0,
    "distance": 101400.0,  },

  {'date': '2024-01-03',
    "kal":512,
    "steps": 474,
    "pt": 100,
    "distance": 1414.0,  },

];
class RunnerDataService {
  final CollectionReference _runnerDataCollection = FirebaseFirestore.instance.collection('runnerData');


  List historyData = [
    {'date': '2024-01-01',
      "kal":512,
      "steps": 114141,
      "pt": 0,
      "distance": 1000.0,  },

    {'date': '2024-01-02',
      "kal":512,
      "steps": 7447,
      "pt": 0,
      "distance": 101400.0,  },

    {'date': '2024-01-03',
      "kal":512,
      "steps": 474,
      "pt": 100,
      "distance": 1414.0,  },

  ];

  Future<List<Map<String, dynamic>>> getHistoryData() async {
    QuerySnapshot querySnapshot = await _runnerDataCollection.where('type', isEqualTo: 'history').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>> getPopularData() async {
    QuerySnapshot querySnapshot = await _runnerDataCollection.where('type', isEqualTo: 'popular').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}


class HistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late  String? userId;

  HistoryService(){
   userId=  FirebaseAuth.instance.currentUser?. uid;
  }

  // Get history data for a specific user
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

  // Set history data for a specific user
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

  // Add a single history entry for a specific user
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

  // Update a specific history entry for a user
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

  // Delete a specific history entry for a user
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