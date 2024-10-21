import 'package:firebase_auth/firebase_auth.dart';


import '../../../../core/errors/Result.dart';
import '../../../../core/errors/failure.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../data/models/user_model.dart';



import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> signInWithEmail(String email, String password);
  Future<Either<Failure, void>> saveCachedUser(UserModel user);
  Future<Either<Failure, UserModel?>> getCachedUser(String userId);
  Future<Either<Failure, bool?>> clearCachedUser(String userId);
  Future<Either<Failure, UserModel>> signUpWithEmail(String email, String password, String roles);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserModel?>> getCurrentUser();
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
  Future<Either<Failure, void>> verifyPhoneNumber(String phoneNumber, Function(String) codeSent);
  Future<Either<Failure, UserModel>> signInWithPhone(String verificationId, String smsCode);
  Future<Either<Failure, UserModel>> signInWithGoogle();
  Future<Either<Failure, UserModel>> signInWithFacebook();
  Future<Either<Failure, UserModel>> signInWithApple();

  Future<Either<Failure, void>> createRoles();
  Future<Either<Failure, List<String>>>fetchRoleNames();
  Future<Either<Failure, UserModel>> createUserData(UserModel userData);
  Future<Either<Failure, UserModel>> updateUserData(UserModel userData);
  Future<Either<Failure, UserModel>> getUserData(String userId);
}
