import '../../data/models/user_model.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> signUpWithEmail(String email, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> verifyPhoneNumber(String phoneNumber, Function(String) codeSent);
  Future<UserModel> signInWithPhone(String verificationId, String smsCode);
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<UserModel> signInWithApple();
}