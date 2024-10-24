part of 'auth_bloc.dart';


abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class SignUpRequestedDone extends AuthState {}



class Unauthenticated extends AuthState {
  final String? message;
  Unauthenticated({this.message});

}
class LoggedOut extends AuthState {}


class RolesLoaded extends AuthState {
  final List<String> roles;

  RolesLoaded(this.roles);
}



class Authenticated extends AuthState {
  final UserDataDataModel user;

  Authenticated(this.user);

  @override
  List<Object> get props => [user];
}
class CreateProfileState extends AuthState {
  final UserDataDataModel user;

  CreateProfileState(this.user);

  @override
  List<Object> get props => [user];
}


class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object> get props => [message];
}
