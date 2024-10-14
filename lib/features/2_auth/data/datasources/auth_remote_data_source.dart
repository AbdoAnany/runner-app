import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../3_home/data/models/user_data_model.dart';

// class AuthRemoteDataSource {
//   // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   // final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//   final FirebaseAuth _firebaseAuth;
//   final FirebaseFirestore _firestore;
//
//   AuthRemoteDataSource(this._firebaseAuth, this._firestore);
//
//   Future<User> signIn(String email, String password) async {
//     UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return userCredential.user!;
//   }
//
//   Future<void> signUp(String email, String password, String role) async {
//     UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     User user = userCredential.user!;
//     UserDataDataModel userDataDataModel=     UserDataDataModel(userId: FirebaseAuth.instance.currentUser!.uid,
//             date: DateTime.now().toIso8601String(),
//             activeNumber: 0,
//             name: "",rank: "D",
//             email:  FirebaseAuth.instance.currentUser!.email??"",
//             phone: FirebaseAuth.instance.currentUser!.phoneNumber??"",
//             roles: "user",
//             adminId: '',
//             currentLevel: 1,
//             currentXP: 1,
//             userState: 'not active',
//             xpForNextLevel: 100,
//             xpProgress: 0);
//     await _firestore.collection('users').doc(user.uid).set({
//       'email': email,
//       'role': role,
//       "userData": userDataDataModel.toMap(),
//     });
//   }
//
//   Future<void> createRoles() async {
//     CollectionReference roles = FirebaseFirestore.instance.collection('roles');
//     await roles.doc('roleDocument').set({
//       'roleNames': ['Admin', 'User', 'Manager', 'Guest'],
//     });
//   }
//
//
//   Future<List<String>> fetchRoleNames() async {
//     DocumentSnapshot snapshot = await FirebaseFirestore.instance
//         .collection('roles')
//         .doc('roleDocument')
//         .get();
//     List<String> roleNames = List<String>.from(snapshot.get('roleNames'));
//
//     return roleNames;
//   }
//
// }

// class FirebaseAuthDataSource {
//   final FirebaseAuth _firebaseAuth;
//   final FirebaseFirestore _fireStore;
//
//   FirebaseAuthDataSource(this._firebaseAuth, this._fireStore);
//   // Email/Password Sign-In
//   Future<User> signIn(String email, String password) async {
//     UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return userCredential.user!;
//   }
//
//   // Email/Password Sign-Up
//   Future<User?> signUp(String email, String password, String role) async {
//     UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     User user = userCredential.user!;
//
//     UserDataDataModel userDataDataModel = UserDataDataModel(
//         userId: user.uid,
//         date: DateTime.now().toIso8601String(),
//         activeNumber: 0,
//         name: "",
//         rank: "D",
//         email: user.email ?? "",
//         phone: user.phoneNumber ?? "",
//         roles: "user",
//         adminId: '',
//         currentLevel: 1,
//         currentXP: 1,
//         userState: 'not active',
//         xpForNextLevel: 100,
//         xpProgress: 0
//     );
//
//     await _fireStore.collection('users').doc(user.uid).set({
//       'email': email,
//       'role': role,
//       "userData": userDataDataModel.toMap(),
//     });
//
//     return user;
//   }
//
//   // Phone Authentication with OTP
//   Future<void> signInWithPhone(String phoneNumber, Function(PhoneAuthCredential) verificationCompleted) async {
//     await _firebaseAuth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: verificationCompleted,
//       verificationFailed: (FirebaseAuthException e) => throw e,
//       codeSent: (String verificationId, int? resendToken) {
//         // Store verificationId and handle the next OTP step
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }
//
//   // Google Sign-In
//   Future<User?> signInWithGoogle() async {
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//
//     if (googleUser == null) return null;
//
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//
//     UserCredential result = await _firebaseAuth.signInWithCredential(credential);
//     return result.user;
//   }
//
//   // Sign Out
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }
//
//   // Create Roles
//   Future<void> createRoles() async {
//     CollectionReference roles = _fireStore.collection('roles');
//
//     await roles.doc('roleDocument').set({
//       'roleNames': ['Admin', 'User', 'Manager', 'Guest'],
//     });
//   }
//
//   // Fetch Role Names
//   Future<List<String>> fetchRoleNames() async {
//     DocumentSnapshot snapshot = await _fireStore
//         .collection('roles')
//         .doc('roleDocument')
//         .get();
//
//     List<String> roleNames = List<String>.from(snapshot.get('roleNames'));
//     return roleNames;
//   }
// }


