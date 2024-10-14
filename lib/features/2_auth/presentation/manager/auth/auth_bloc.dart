import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:runner_app/features/2_auth/data/repositories/firebase_auth.dart';

import '../../../../../core/usecase/use_case.dart';

import '../../../../../dependency_injection.dart';
import '../../../data/datasources/firebase_auth_remote_data_source.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/repositories/FirebaseAuthRemoteDataSource.dart';
import '../../../domain/use_cases/get_cached_user.dart';
import '../../../domain/use_cases/get_current_user.dart';
import '../../../domain/use_cases/role_load.dart';
import '../../../domain/use_cases/save_cached_user.dart';
import '../../../domain/use_cases/sign_in_with_email.dart';
import '../../../domain/use_cases/sign_in_with_google.dart';
import '../../../domain/use_cases/sign_out.dart';
import '../../../domain/use_cases/sign_up_with_email.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmail signInWithEmail;
  final SignUpWithEmail signUpWithEmail;
  final SignInWithGoogle signInWithGoogle;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
  final SaveCachedUser saveCachedUser;
  final GetCachedUser getCachedUser;
  final RolesLoad rolesLoad;
  AuthBloc({
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.signOut,
    required this.signInWithGoogle,
    required this.getCurrentUser,
    required this.saveCachedUser,
    required this.getCachedUser,
    required this.rolesLoad,
  }) : super(AuthInitial()) {
    on<SignInWithEmailEvent>(_onSignInWithEmail);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignUpWithEmailEvent>(_onSignUpWithEmail);
    on<SignOutEvent>(_onSignOut);
    on<GetCurrentUserEvent>(_onGetCurrentUser);
    on<CheckCachedUserEvent>(_onCheckCachedUser);
    on<LoadRolesRequestedEvent>(_getLoadRoles);
  }

  Future<void> _onSignInWithEmail(
      SignInWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await signInWithEmail(
        SignInWithEmailParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) async {
        if (event.rememberMe) {
          await saveCachedUser(user);
        }
        emit(Authenticated(user));
      },
    );
  }

  Future<void> _onSignInWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signInWithGoogle(NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _getLoadRoles(
      LoadRolesRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await rolesLoad(NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) => emit(RolesLoaded(user)),
    );
  }

  Future<void> _onSignUpWithEmail(
      SignUpWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signUpWithEmail(
        SignUpWithEmailParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signOut(NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (_) => emit(Unauthenticated()),
    );
  }

  Future<void> _onGetCurrentUser(
      GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await getCurrentUser(NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) =>
          user != null ? emit(Authenticated(user)) : emit(Unauthenticated()),
    );
  }

  Future<void> _onCheckCachedUser(
      CheckCachedUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await getCachedUser(NoParams());
    result.fold(
      (failure) => emit(Unauthenticated()),
      (user) =>
          user != null ? emit(Authenticated(user)) : emit(Unauthenticated()),
    );
  }
}


