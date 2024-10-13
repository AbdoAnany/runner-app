import 'package:firebase_auth/firebase_auth.dart';


import '../../../../core/errors/Result.dart';
import '../../../../core/errors/failure.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../data/models/user_model.dart';



import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> signInWithEmail(String email, String password);
  Future<Either<Failure, void>> saveCachedUser(UserModel user);
  Future<Either<Failure, UserModel?>> getCachedUser();
  Future<Either<Failure, UserModel>> signUpWithEmail(String email, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserModel?>> getCurrentUser();
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
  Future<Either<Failure, void>> verifyPhoneNumber(String phoneNumber, Function(String) codeSent);
  Future<Either<Failure, UserModel>> signInWithPhone(String verificationId, String smsCode);
  Future<Either<Failure, UserModel>> signInWithGoogle();
  Future<Either<Failure, UserModel>> signInWithFacebook();
  Future<Either<Failure, UserModel>> signInWithApple();

  // Future<Result<void>> createRoles();
  // Future<Result<List<String>>> fetchRoleNames();
  // Future<Result<UserDataDataModel>> createUserData(UserDataDataModel userData);
  // Future<Result<UserDataDataModel>> updateUserData(UserDataDataModel userData);
  // Future<Result<UserDataDataModel>> getUserData(String userId);
}
