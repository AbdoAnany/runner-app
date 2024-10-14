// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<User?> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return result.user;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//   Future<User?> registerWithEmailAndPassword(String email, String password, String role) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       await _firestore.collection('users').doc(result.user!.uid).set({
//         'email': email,
//         'role': role,
//       });
//       return result.user;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//   Future<void> signOut() async {
//     try {
//       return await _auth.signOut();
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//   Future<String?> getUserRole(String uid) async {
//     try {
//       DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
//       return doc['role'] as String?;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }
