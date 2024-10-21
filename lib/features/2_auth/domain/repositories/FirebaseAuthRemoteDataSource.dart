import '../../data/models/user_model.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> signUpWithEmail(String email, String password, String roles);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> verifyPhoneNumber(String phoneNumber, Function(String) codeSent);
  Future<UserModel> signInWithPhone(String verificationId, String smsCode);
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<UserModel> signInWithApple();

  Future<void> createRoles();
  Future< List<String>>fetchRoleNames();
  Future<UserModel> createUserData(UserModel userData);
  Future<UserModel> updateUserData(UserModel userData);
  Future<UserModel?> getUserData(String userId);
}