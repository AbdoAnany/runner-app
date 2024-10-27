

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class  UserDateSources   {
final FirebaseAuth _firebaseAuth;

final FirebaseFirestore _fireStore;
// UserDateSources({
// required FirebaseAuth firebaseAuth,
//
// required FirebaseFirestore fireStore,
//
// })  :
// _fireStore = fireStore,
// _firebaseAuth = firebaseAuth,



UserDateSources._(this._firebaseAuth, this._fireStore);
  static final UserDateSources _instance = UserDateSources._(FirebaseAuth.instance, FirebaseFirestore.instance);
  static UserDateSources get instance => _instance;

  Future<bool> addUserDataEntry(Map<String, dynamic> entry,) async {
    try {
      await _fireStore
          .collection('users')
          .doc(entry['userId'])
          .update({'userData': entry});

      print('UserData entry  ${entry} added successfully');

      return true;
    } catch (e) {
      print('Error adding UserData entry: $e');
      return false;
    }
  }

}
