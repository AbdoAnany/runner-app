import '../../../data/models/User.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class SignUpRequestedDone extends AuthState {}

class Authenticated extends AuthState {
  final UserModel user;

  Authenticated(this.user);
}

class Unauthenticated extends AuthState {
  final String? message;
  Unauthenticated({this.message});

}
class LoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class RolesLoaded extends AuthState {
  final List<String> roles;

  RolesLoaded(this.roles);
}
