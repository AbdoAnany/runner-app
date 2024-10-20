// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/usecase/use_case.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/use_cases/clear_user_date_cached.dart';
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
  final ClearUserDateCached clearUserDateCached;
  final RolesLoad rolesLoad;

  AuthBloc({
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.signOut,
    required this.signInWithGoogle,
    required this.getCurrentUser,
    required this.saveCachedUser,
    required this.getCachedUser,
    required this.clearUserDateCached,
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
      SignInWithEmailParams(email: event.email, password: event.password),
    );

    if (emit.isDone) return; // Check if the emitter is still valid

    await result.fold(
      (failure) async => emit(AuthError(failure.toString())),
      (user) async {
        if (event.rememberMe) {
          await saveCachedUser(user);
        }
        if (emit.isDone) return; // Check again after the async operation
        emit(Authenticated(user));
      },
    );
  }

  Future<void> _onSignInWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await signInWithGoogle(NoParams());

    if (emit.isDone) return; // Check if the emitter is still valid

    await result.fold(
      (failure) async => emit(AuthError(failure.toString())),
      (user) async {
        await saveCachedUser(user);
        if (emit.isDone) return; // Check again after the async operation
        emit(Authenticated(user));
      },
    );
  }

  Future<void> _onSignUpWithEmail(
      SignUpWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await signUpWithEmail(
      SignUpWithEmailParams(
        email: event.email,
        password: event.password,
        roles: event.roles,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) async {
        await saveCachedUser(user);
        emit(Authenticated(user));
      },
    );
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await signOut(NoParams());
    final isCleared = await clearUserDateCached(event.userId);

    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (_) => emit(Unauthenticated()),
    );
  }

  Future<void> _onGetCurrentUser(
      GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await getCurrentUser(event.userId);

    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) =>
          user != null ? emit(Authenticated(user)) : emit(Unauthenticated()),
    );
  }

  Future<void> _onCheckCachedUser(
      CheckCachedUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await getCachedUser(event.userId);

    print(result);
    result.fold(
      (failure) => emit(Unauthenticated()),
      (user) =>
          user != null ? emit(Authenticated(user)) : emit(Unauthenticated()),
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
}
