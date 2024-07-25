abstract class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;
  final bool? rememberMe;

  SignInRequested({required this.email, required this.password, this.rememberMe = false});
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String role;

  SignUpRequested(this.email, this.password, this.role);
}

class UserIsLogIn extends AuthEvent {}
class ReloadState extends AuthEvent {}
class LoadRolesRequested extends AuthEvent {}
class SignOutRequested extends AuthEvent {}
