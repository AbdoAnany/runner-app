import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/failure.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../domain/repositories/FirebaseAuthRemoteDataSource.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthRemoteDataSource remoteDataSource;

  FirebaseAuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, void>> saveCachedUser(UserDataDataModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cached_user${user.userId}', json.encode(user.toMap()));
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure("Failed to save cached user"));
    }
  }
  @override
  Future<Either<Failure, UserDataDataModel?>> getCachedUser(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('cached_user$userId');
      if (userJson != null) {
        return Right(UserDataDataModel.fromJson(json.decode(userJson)));
      }
      return Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to get save user'));
    }
  }
  @override
  Future<Either<Failure, bool?>> clearCachedUser(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = await prefs.remove('cached_user$userId');
      if (userJson != null) {
        return Right(userJson);
      }
      return Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to get save user'));
    }
  }


  @override
  Future<Either<Failure, UserDataDataModel>> signInWithEmail(
      String email, String password) async {
    try {
      final user = await remoteDataSource.signInWithEmail(email, password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'An unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserDataDataModel>> signUpWithEmail(
      String email, String password, String roles) async {
    try {
      final user = await remoteDataSource.signUpWithEmail(email, password, roles);
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
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await remoteDataSource.sendPasswordResetEmail(email);
      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(
          AuthFailure(e.message ?? 'Failed to send password reset email'));
    }
  }

  @override
  Future<Either<Failure, void>> verifyPhoneNumber(
      String phoneNumber, Function(String) codeSent) async {
    try {
      await remoteDataSource.verifyPhoneNumber(phoneNumber, codeSent);
      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Failed to verify phone number'));
    }
  }

  @override
  Future<Either<Failure, UserDataDataModel>> signInWithPhone(
      String verificationId, String smsCode) async {
    try {
      final user =
          await remoteDataSource.signInWithPhone(verificationId, smsCode);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Failed to sign in with phone'));
    }
  }

  @override
  Future<Either<Failure, UserDataDataModel>> signInWithGoogle() async {
    try {
      final user = await remoteDataSource.signInWithGoogle();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Failed to sign in with Google'));
    }
  }

  @override
  Future<Either<Failure, UserDataDataModel>> signInWithFacebook() async {
    try {
      final user = await remoteDataSource.signInWithFacebook();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Failed to sign in with Facebook'));
    }
  }

  @override
  Future<Either<Failure, UserDataDataModel>> signInWithApple() async {
    try {
      final user = await remoteDataSource.signInWithApple();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Failed to sign in with Apple'));
    }
  }



  @override
  Future<Either<Failure, void>> createRoles() async {
    try {
      await remoteDataSource.createRoles();
      return Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to get save user'));
    }
  }

  @override
  Future<Either<Failure, UserDataDataModel>> createUserData(UserDataDataModel userData) async {
    try {
      await remoteDataSource.createUserData(userData);
      return Right(userData);
    } catch (e) {
      return const Left(CacheFailure('Failed to create roles'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> fetchRoleNames() async {
    try {
      List<String> roleNames = await remoteDataSource.fetchRoleNames();

      return Right(roleNames);
    } catch (e) {
      return const Left(CacheFailure('Failed to get save user'));
    }
  }

  @override
  Future<Either<Failure, UserDataDataModel?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return const Left(AuthFailure('Failed to get current user'));
    }
  }

  @override
  Future<Either<Failure, UserDataDataModel>> getUserData(String userId) async {
    try {
      final user = await remoteDataSource.getUserData(userId);
      if (user != null) {
        return Right(user);
      } else {
        return const Left(AuthFailure('not found user'));
      }
    } catch (e) {
      return Left(AuthFailure('Failed to sign in with ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserDataDataModel>> updateUserData(UserDataDataModel userData) async {
    try {
      final user = await remoteDataSource.updateUserData(userData);

      return Right(user);
    } catch (e) {
      return Left(AuthFailure('Failed to update user data: ${e.toString()}'));
    }
  }
}
