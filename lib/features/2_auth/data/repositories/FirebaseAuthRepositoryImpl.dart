import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/FirebaseAuthRemoteDataSource.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthRemoteDataSource remoteDataSource;

  FirebaseAuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserModel>> signInWithEmail(String email, String password) async {
    try {
      final user = await remoteDataSource.signInWithEmail(email, password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'An unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmail(String email, String password) async {
    try {
      final user = await remoteDataSource.signUpWithEmail(email, password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'An unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return Right(null);
    } catch (e) {
      return Left(AuthFailure('Failed to sign out'));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(AuthFailure('Failed to get current user'));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await remoteDataSource.sendPasswordResetEmail(email);
      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Failed to send password reset email'));
    }
  }

  @override
  Future<Either<Failure, void>> verifyPhoneNumber(String phoneNumber, Function(String) codeSent) async {
    try {
      await remoteDataSource.verifyPhoneNumber(phoneNumber, codeSent);
      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Failed to verify phone number'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithPhone(String verificationId, String smsCode) async {
    try {
      final user = await remoteDataSource.signInWithPhone(verificationId, smsCode);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Failed to sign in with phone'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    try {
      final user = await remoteDataSource.signInWithGoogle();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Failed to sign in with Google'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithFacebook() async {
    try {
      final user = await remoteDataSource.signInWithFacebook();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Failed to sign in with Facebook'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithApple() async {
    try {
      final user = await remoteDataSource.signInWithApple();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Failed to sign in with Apple'));
    }
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
      return Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to get save user'));
    }
  }

  @override
  Future<Either<Failure, void>>  createRoles() async {

    try {
      CollectionReference roles = FirebaseFirestore.instance.collection('roles');
      await roles.doc('roleDocument').set({
        'roleNames': ['Admin', 'User', 'Manager', 'Guest'],
      });
      return Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to get save user'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> createUserData(UserModel userData) async {
        try {
          await FirebaseFirestore.instance
          .collection('users')
          .doc(userData.id)
          .set(userData.toMap());
          return Right(userData);

    } catch (e) {
          return  const Left(CacheFailure('Failed to create roles'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> fetchRoleNames() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('roles')
          .doc('roleDocument')
          .get();

      List<String> roleNames = List<String>.from(snapshot.get('roleNames'));

      return Right(roleNames);
    } catch (e) {
      return  const Left(CacheFailure('Failed to get save user'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserData(String userId) async {

    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (doc.exists) {
        return Right(UserModel.fromJson(doc.data() as Map<String, dynamic>));
      } else {
        return   const Left(AuthFailure( 'not found user'));
      }
    } catch (e) {
      return  Left(AuthFailure( 'Failed to sign in with ${e.toString()}'));
    }

  }

  @override
  Future<Either<Failure, UserModel>> updateUserData(UserModel userData) async {
        try {
          await FirebaseFirestore.instance
          .collection('users')
          .doc(userData.id)
          .update(userData.toMap());
          return Right(UserModel.fromJson(userData.toMap()));
    } catch (e) {
          return  Left(AuthFailure( 'Failed to update user data: ${e.toString()}'));

    }
  }





}