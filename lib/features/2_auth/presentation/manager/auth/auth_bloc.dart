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
  AuthBloc({
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.signOut,
    required this.signInWithGoogle,
    required this.getCurrentUser,
    required this.saveCachedUser,
    required this.getCachedUser,
  }) : super(AuthInitial()) {
    on<SignInWithEmailEvent>(_onSignInWithEmail);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignUpWithEmailEvent>(_onSignUpWithEmail);
    on<SignOutEvent>(_onSignOut);
    on<GetCurrentUserEvent>(_onGetCurrentUser);
    on<CheckCachedUserEvent>(_onCheckCachedUser);
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
      (user) => user != null ? emit(Authenticated(user)) : emit(Unauthenticated()),
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

// class AuthBloc1 extends Bloc<AuthEvent, AuthState> {
//   final SignInWithEmail signInWithEmail;
//   final SignUpWithEmail signUpWithEmail;
//   static UserModel? currentUser;
//   static List<String> roles = [];
//   static runEvent(event) => BlocProvider.of<AuthBloc>(Get.context).add(event);
//
//   AuthBloc1({required this.signInWithEmail, required this.signUpWithEmail})
//       : super(AuthInitial()) {
//     on<UserIsLogIn>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//
//
//         var user = prefs.get("user",);
//         bool rememberMe = prefs.get("rememberMe",) as bool;
//         if (user != null && rememberMe) {
//           var userJson = jsonDecode(user.toString());
//           final userDate = UserModel.fromJson(userJson);
//           currentUser = userDate;
//           emit(Authenticated(userDate));
//         } else {
//           emit(AuthInitial());
//
//
//         }
//       } catch (e) {
//         emit(AuthError(e.toString()));
//       }
//     });
//     on<ReloadState>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         emit(RolesLoaded(roles));
//       } catch (e) {
//         emit(AuthError(e.toString()));
//       }
//     });
//
//     on<SignInRequested>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setBool('rememberMe',event.rememberMe??false) ;
//         final user = await signInWithEmail(SignInWithEmailParams(email: event.email, password: event.password));
//         final userJson = jsonEncode(user.data?.toJson());
//         prefs.setString("user", userJson);
//         currentUser = user.data;
//
//
//         emit(Authenticated(user.data!));
//       } catch (e) {
//
//         print('sssssssssssssssss');
//         print(e);
//         String errorMessage;
//
//         // Check if the error is a FirebaseAuthException
//         if (e is FirebaseAuthException) {
//           switch (e.code) {
//             case 'email-already-in-use':
//               errorMessage =
//               "The email address is already in use by another account.";
//               break;
//             case 'invalid-email':
//               errorMessage = "The email address is not valid.";
//               break;
//             case 'weak-password':
//               errorMessage = "The password is too weak.";
//               break;
//             case 'operation-not-allowed':
//               errorMessage = "Email/password accounts are not enabled.";
//               break;
//             default:
//               errorMessage = "An unknown error occurred. Please try again.";
//               break;
//           }
//         } else {
//           // Fallback for any other exception types
//           errorMessage = "An unexpected error occurred. Please try again.";
//         }
//
//         emit(AuthError(errorMessage));
//       }
//     });
//
//     on<SignUpRequested>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         // Attempt to sign up using the provided use case
//         await signUpUseCase(event.email, event.password, event.role);
//
//         emit(SignUpRequestedDone());
//       } catch (e) {
//         String errorMessage;
//
//         // Check if the error is a FirebaseAuthException
//         if (e is FirebaseAuthException) {
//           switch (e.code) {
//             case 'email-already-in-use':
//               errorMessage =
//               "The email address is already in use by another account.";
//               break;
//             case 'invalid-email':
//               errorMessage = "The email address is not valid.";
//               break;
//             case 'weak-password':
//               errorMessage = "The password is too weak.";
//               break;
//             case 'operation-not-allowed':
//               errorMessage = "Email/password accounts are not enabled.";
//               break;
//             default:
//               errorMessage = "An unknown error occurred. Please try again.";
//               break;
//           }
//         } else {
//           // Fallback for any other exception types
//           errorMessage = "An unexpected error occurred. Please try again.";
//         }
//
//
//
//         // Emit an AuthError state with a user-friendly error message
//         emit(AuthError(errorMessage));
//       }
//     });
//     on<LoadRolesRequested>((event, emit) async {
//       emit(AuthLoading());
//       print("??????????????  LoadRolesRequested");
//       try {
//         roles = (await signUpUseCase.repository.fetchRoleNames()).data!;
//         print("signUpUseCase  RolesLoaded   ${roles.toString()}");
//         emit(RolesLoaded(roles));
//       } catch (e) {
//         print("xxxxxxxxxxxxxx  AuthError   ${e.toString()}");
//         emit(AuthError('Failed to load roles'));
//       }
//     });
//
//     on<SignOutRequested>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.remove('email');
//         prefs.remove('password');
//         prefs.setBool('rememberMe', false);
//         await FirebaseAuth.instance.signOut();
//         //  Get. context.pushScreen(LoginScreen());
//
//         emit(LoggedOut());
//       } catch (e) {
//         emit(AuthError('Failed to sign out'));
//       }
//     });
//   }
// }
