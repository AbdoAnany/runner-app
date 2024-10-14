
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/repositories/FirebaseAuthRemoteDataSource.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';


class FirebaseAuthRemoteDataSourceImpl implements FirebaseAuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;

  FirebaseAuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required FacebookAuth facebookAuth,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _facebookAuth = facebookAuth;

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebaseUser(userCredential.user!);
  }

  @override
  Future<UserModel> signUpWithEmail(String email, String password, String roles) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user!.sendEmailVerification();
    return UserModel.fromFirebaseUser(userCredential.user!);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    await _facebookAuth.logOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber, Function(String) codeSent) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        throw e;
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Future<UserModel> signInWithPhone(String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return UserModel.fromFirebaseUser(userCredential.user!);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return UserModel.fromFirebaseUser(userCredential.user!);
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    final LoginResult result = await _facebookAuth.login();
    final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return UserModel.fromFirebaseUser(userCredential.user!);
  }

  @override
  Future<UserModel> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(oauthCredential);
    return UserModel.fromFirebaseUser(userCredential.user!);
  }
}
