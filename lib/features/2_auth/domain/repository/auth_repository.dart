import '../../data/models/User.dart';

abstract class AuthRepository {
  Future<UserModel> signIn(String email, String password);
  Future<void> signUp(String email, String password, String role);
  Future<List<String>> fetchRoleNames();
}
