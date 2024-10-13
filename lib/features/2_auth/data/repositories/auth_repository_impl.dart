import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:runner_app/core/errors/Result.dart';
import 'package:runner_app/core/errors/failure.dart';
import 'package:runner_app/features/2_auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../3_home/data/models/user_data_model.dart';
import '../../domain/repositories/auth_repository.dart';

// Updated AuthRepositoryImpl
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl(this._firebaseAuth, this._firestore);

  @override
  Future<Result<UserModel>> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        displayName: userCredential.user!.displayName,
        photoUrl: userCredential.user!.photoURL,
        role: 'user',
        isEmailVerified: userCredential.user!.emailVerified,
      );
      return Result(data: user);
    } on FirebaseAuthException catch (e) {
      return Result(error: e.message);
    } catch (e) {
      return Result(error: 'An unexpected error occurred');
    }
  }

  @override
  Future<Result<UserModel>> signUp(
      String email, String password, String role) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        role: role,

        displayName: userCredential.user!.displayName,
        photoUrl: userCredential.user!.photoURL,
        isEmailVerified: userCredential.user!.emailVerified,
      );

      // Create initial user data
      await createUserData(UserDataDataModel(
        userId: user.id,
        date: DateTime.now().toIso8601String(),
        name: userCredential.user!.displayName??'',
        email: email,
        roles: role,
        currentLevel: 1,
        currentXP: 0,
        xpProgress: 0,
      ));

      return Result(data: user);
    } on FirebaseAuthException catch (e) {
      return Result(error: e.message);
    } catch (e) {
      return Result(error: 'An unexpected error occurred');
    }
  }

  // Implement other auth methods (signInWithPhone, signInWithGoogle, signOut, createRoles, fetchRoleNames) similarly...

  @override
  Future<Result<UserDataDataModel>> createUserData(
      UserDataDataModel userData) async {
    try {
      await _firestore
          .collection('users')
          .doc(userData.userId)
          .set(userData.toMap());
      return Result(data: userData);
    } catch (e) {
      return Result(error: 'Failed to create user data: ${e.toString()}');
    }
  }

  @override
  Future<Result<UserDataDataModel>> updateUserData(
      UserDataDataModel userData) async {
    try {
      await _firestore
          .collection('users')
          .doc(userData.userId)
          .update(userData.toMap());
      return Result(data: userData);
    } catch (e) {
      return Result(error: 'Failed to update user data: ${e.toString()}');
    }
  }

  @override
  Future<Result<UserDataDataModel>> getUserData(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return Result(
            data:
                UserDataDataModel.fromMap(doc.data() as Map<String, dynamic>));
      } else {
        return Result(error: 'User data not found');
      }
    } catch (e) {
      return Result(error: 'Failed to get user data: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> createRoles() {
    // TODO: implement createRoles
    throw UnimplementedError();
  }

  @override
  Future<Result<List<String>>> fetchRoleNames() {
    // TODO: implement fetchRoleNames
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel?>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signInWithEmail(String email, String password) {
    // TODO: implement signInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signInWithPhone(String verificationId, String smsCode) {
    // TODO: implement signInWithPhone
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmail(String email, String password) {
    // TODO: implement signUpWithEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> verifyPhoneNumber(String phoneNumber, Function(String p1) codeSent) {
    // TODO: implement verifyPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> saveCachedUser(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cached_user', json.encode(user.toMap()));
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure("Failed to save cached user"));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getCachedUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('cached_user');
      if (userJson != null) {
        return Right(UserModel.fromJson(json.decode(userJson)));
      }
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure("Failed to get cached user"));
    }
  }
}



