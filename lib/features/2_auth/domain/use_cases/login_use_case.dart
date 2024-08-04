import '../../data/models/User.dart';
import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserModel>? call(String email, String password) {
    return repository.signIn(email, password);
  }
}
