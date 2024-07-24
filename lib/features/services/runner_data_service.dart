import 'package:cloud_firestore/cloud_firestore.dart';


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



  Future<List<Map<String, dynamic>>> getHistoryData() async {
    QuerySnapshot querySnapshot = await _runnerDataCollection.where('type', isEqualTo: 'history').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>> getPopularData() async {
    QuerySnapshot querySnapshot = await _runnerDataCollection.where('type', isEqualTo: 'popular').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}
