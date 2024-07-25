import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    await _fireStore.collection('users').doc(user.uid).set({
      'email': email,
      'role': role,
    });
  }

  Future<List<String>> fetchRoles() async {
    QuerySnapshot snapshot = await _fireStore.collection('roles').get();
    print(snapshot.docs.first.id);
    print(snapshot.docs.first.data());
    return snapshot.docs.map((doc) => doc.id).toList();
  }
}
