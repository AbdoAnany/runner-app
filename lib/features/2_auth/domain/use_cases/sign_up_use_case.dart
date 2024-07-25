import '../repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<void> call(String email, String password, String role) {
    return repository.signUp(email, password, role);
  }
}
