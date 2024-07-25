import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn(String email, String password);
  Future<void> signUp(String email, String password, String role);
  Future<List<String>> fetchRoles();
}
