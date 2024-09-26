import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../3_home/data/models/user_data_model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<User> signIn(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user!;
  }

  Future<void> signUp(String email, String password, String role) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = userCredential.user!;
    UserDataDataModel userDataDataModel=     UserDataDataModel(userId: FirebaseAuth.instance.currentUser!.uid,
            date: DateTime.now().toIso8601String(),
            activeNumber: 0,
            name: "",rank: "D",
            email:  FirebaseAuth.instance.currentUser!.email??"",
            phone: FirebaseAuth.instance.currentUser!.phoneNumber??"",
            roles: "user",
            adminId: '',
            currentLevel: 1,
            currentXP: 1,
            userState: 'not active',
            xpForNextLevel: 100,
            xpProgress: 0);
    await _fireStore.collection('users').doc(user.uid).set({
      'email': email,
      'role': role,
      "userData": userDataDataModel.toMap(),
    });
  }
  Future<void> createRoles() async {
    CollectionReference roles = FirebaseFirestore.instance.collection('roles');

    // Add a new document with a list of role names
    await roles.doc('roleDocument').set({
      'roleNames': ['Admin', 'User', 'Manager', 'Guest'],
    });
  }
  Future<List<String>> fetchRoleNames() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('roles')
        .doc('roleDocument')
        .get();

    // Extract the 'roleNames' list
   List<String> roleNames = List<String>.from(snapshot.get('roleNames'));

    return roleNames;
  }

}
