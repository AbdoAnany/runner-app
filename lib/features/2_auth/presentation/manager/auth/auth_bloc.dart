// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:runner_app/features/2_auth/data/models/UserDataDataModel.dart';
import '../../../../../core/usecase/use_case.dart';

import '../../../../3_home/data/models/user_data_model.dart';
import '../../../domain/use_cases/clear_user_date_cached.dart';
import '../../../domain/use_cases/create_profile.dart';
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
  final CreateProfile createProfile;
  final ClearUserDateCached clearUserDateCached;
  final RolesLoad rolesLoad;

  AuthBloc({
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.signOut,
    required this.signInWithGoogle,
    required this.getCurrentUser,
    required this.saveCachedUser,
    required this.createProfile,
    required this.getCachedUser,
    required this.clearUserDateCached,
    required this.rolesLoad,
  }) : super(AuthInitial()) {
    on<SignInWithEmailEvent>(_onSignInWithEmail);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignUpWithEmailEvent>(_onSignUpWithEmail);
    on<CreateUserDataEvent>(_createUserData);
    on<SignOutEvent>(_onSignOut);
    on<GetCurrentUserEvent>(_onGetCurrentUser);
    on<CheckCachedUserEvent>(_onCheckCachedUser);
    on<LoadRolesRequestedEvent>(_getLoadRoles);
  }

  Future<void> _onSignInWithEmail(
      SignInWithEmailEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      final result = await signInWithEmail(
        SignInWithEmailParams(email: event.email, password: event.password),
      );

      await result.fold(
        (failure) async => emit(AuthError(failure.toString())),
        (userData) async {
          try {
            if (event.rememberMe) {
              await saveCachedUser(userData);
            }

            emit(Authenticated(userData));
          } catch (e) {
            emit(AuthError('Error processing user data: ${e.toString()}'));
          }
        },
      );
    } catch (e) {
      emit(AuthError('Authentication error: ${e.toString()}'));
    }
  }

  Future<void> _onSignInWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await signInWithGoogle(NoParams());
    print("------------------------  result ------------------");
    print(result);
    await result.fold(
      (failure) async => emit(Unauthenticated()),
      (userData) async {
        print("------------------------  result 123------------------");
        final fcmToken = await FirebaseMessaging.instance.getToken();
        userData.fcmToken= fcmToken;
        await saveCachedUser(userData);
        await createProfile(userData);
        emit(Authenticated(userData));
      },
    );
  }

  Future<void> _createUserData(
      CreateUserDataEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await createProfile(event.userData);
    print("------------------------  result ------------------");
    print(result);
    await result.fold(
      (failure) async => emit(Unauthenticated()),
      (userData) async {
        print("------------------------  result 123------------------");

        await saveCachedUser(userData!);
        emit(CreateProfileState(userData!));
      },
    );
  }

  Future<void> _onSignUpWithEmail(
      SignUpWithEmailEvent event, Emitter<AuthState> emit) async {
    try {
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
        (userData) async {
          try {
            final fcmToken = await FirebaseMessaging.instance.getToken();
            userData.fcmToken = fcmToken;
            await saveCachedUser(userData);
            await createProfile(userData);

            emit(Authenticated(userData));
          } catch (e) {
            emit(AuthError('Error processing signup data: ${e.toString()}'));
          }
        },
      );
    } catch (e) {
      emit(AuthError('Sign-up error: ${e.toString()}'));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      final result = await signOut(NoParams());
      final isCleared = await clearUserDateCached(event.userId);

      result.fold(
        (failure) => emit(AuthError(failure.toString())),
        (_) => emit(Unauthenticated()),
      );
    } catch (e) {
      emit(AuthError('Sign-out error: ${e.toString()}'));
    }
  }

  Future<void> _onGetCurrentUser(
      GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      final result = await getCurrentUser(event.userId);

      result.fold(
        (failure) => emit(AuthError(failure.toString())),
        (userData) {
          if (userData == null) {
            emit(Unauthenticated());
          } else {
            emit(Authenticated(userData));
          }
        },
      );
    } catch (e) {
      emit(AuthError('Get current user error: ${e.toString()}'));
    }
  }

  Future<void> _onCheckCachedUser(
      CheckCachedUserEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      final result = await getCachedUser(event.userId);

      result.fold(
        (failure) => emit(Unauthenticated()),
        (userData) {
          if (userData == null) {
            emit(Unauthenticated());
          } else {
            emit(Authenticated(userData));
          }
        },
      );
    } catch (e) {
      emit(AuthError('Check cached user error: ${e.toString()}'));
    }
  }

  Future<void> _getLoadRoles(
      LoadRolesRequestedEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      final result = await rolesLoad(NoParams());

      result.fold(
        (failure) => emit(AuthError(failure.toString())),
        (roles) => emit(RolesLoaded(roles)),
      );
    } catch (e) {
      emit(AuthError('Load roles error: ${e.toString()}'));
    }
  }
}
