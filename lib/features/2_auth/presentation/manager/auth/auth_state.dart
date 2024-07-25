import '../../../domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserEntity user;

  Authenticated(this.user);
}

class Unauthenticated extends AuthState {}
class LoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class RolesLoaded extends AuthState {
  final List<String> roles;

  RolesLoaded(this.roles);
}
