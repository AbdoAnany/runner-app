import 'package:cloud_firestore/cloud_firestore.dart';

class RunnerDataService {
  final CollectionReference _runnerDataCollection = FirebaseFirestore.instance.collection('runnerData');

  Future<List<Map<String, dynamic>>> getHistoryData() async {
    QuerySnapshot querySnapshot = await _runnerDataCollection.where('type', isEqualTo: 'history').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>> getPopularData() async {
    QuerySnapshot querySnapshot = await _runnerDataCollection.where('type', isEqualTo: 'popular').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}
