import '../../../3_home/data/models/user_data_model.dart';
import '../../data/models/user_model.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<UserDataDataModel> signInWithEmail(String email, String password);
  Future<UserDataDataModel> signUpWithEmail(String email, String password, String roles);
  Future<void> signOut();
  Future<UserDataDataModel?> getCurrentUser();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> verifyPhoneNumber(String phoneNumber, Function(String) codeSent);
  Future<UserDataDataModel> signInWithPhone(String verificationId, String smsCode);
  Future<UserDataDataModel> signInWithGoogle();
  Future<UserDataDataModel> signInWithFacebook();
  Future<UserDataDataModel> signInWithApple();

  Future<void> createRoles();
  Future< List<String>>fetchRoleNames();
  Future<UserDataDataModel> createUserData(UserDataDataModel userData);
  Future<UserDataDataModel> updateUserData(UserDataDataModel userData);
  Future<UserDataDataModel?> getUserData(String userId);
}