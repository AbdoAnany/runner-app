import 'package:firebase_auth/firebase_auth.dart';


import '../../../../core/errors/Result.dart';
import '../../../../core/errors/failure.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../data/models/user_model.dart';



import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserDataDataModel>> signInWithEmail(String email, String password);
  Future<Either<Failure, void>> saveCachedUser(UserDataDataModel user);
  Future<Either<Failure, UserDataDataModel?>> getCachedUser(String userId);
  Future<Either<Failure, bool?>> clearCachedUser(String userId);
  Future<Either<Failure, UserDataDataModel>> signUpWithEmail(String email, String password, String roles);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserDataDataModel?>> getCurrentUser();
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
  Future<Either<Failure, void>> verifyPhoneNumber(String phoneNumber, Function(String) codeSent);
  Future<Either<Failure, UserDataDataModel>> signInWithPhone(String verificationId, String smsCode);
  Future<Either<Failure, UserDataDataModel>> signInWithGoogle();
  Future<Either<Failure, UserDataDataModel>> signInWithFacebook();
  Future<Either<Failure, UserDataDataModel>> signInWithApple();

  Future<Either<Failure, void>> createRoles();
  Future<Either<Failure, List<String>>>fetchRoleNames();
  Future<Either<Failure, UserDataDataModel>> createUserData(UserDataDataModel userData);
  Future<Either<Failure, UserDataDataModel>> updateUserData(UserDataDataModel userData);
  Future<Either<Failure, UserDataDataModel>> getUserData(String userId);
}
