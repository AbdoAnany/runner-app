part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}
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



class SignInWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;
  SignInWithEmailEvent({required this.email, required this.password,this.rememberMe=false});

  @override
  List<Object> get props => [email, password,rememberMe];
}
class SignInWithGoogleEvent extends AuthEvent {


  SignInWithGoogleEvent();

  @override
  List<Object> get props => [ ];
}

class SignUpWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  final String roles;

  SignUpWithEmailEvent({required this.email, required this.password, required this.roles});

  @override
  List<Object> get props => [email, password,roles];
}

class SignOutEvent extends AuthEvent {}

class GetCurrentUserEvent extends AuthEvent {}
class CheckCachedUserEvent extends AuthEvent {}
class LoadRolesRequestedEvent extends AuthEvent {}

// Add other events for different authentication methods