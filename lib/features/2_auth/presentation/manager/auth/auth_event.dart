


abstract class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String role;

  SignUpRequested(this.email, this.password, this.role);
}

class SignOutRequested extends AuthEvent {}
