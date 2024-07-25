import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runner_app/core/helper/extension.dart';
import 'package:runner_app/features/2_auth/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../my_app.dart';
import '../../../data/repositories/firebase_auth.dart';
import '../../../domain/use_cases/login_use_case.dart';
import '../../../domain/use_cases/sign_up_use_case.dart';
import '../../pages/login_screen.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:bloc/bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  static UserEntity? currentUser;
  static List<String> roles = [];
  static runEvent(event) => BlocProvider.of<AuthBloc>(Get.context).add(event);

  AuthBloc({required this.loginUseCase, required this.signUpUseCase})
      : super(AuthInitial()) {
    on<UserIsLogIn>((event, emit) async {
      emit(AuthLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var user = prefs.get(
          "user",
        );
        if (user != null) {
          var userJson = jsonDecode(user.toString());
          final userDate = UserEntity.fromJson(userJson);
          currentUser = userDate;
          emit(Authenticated(userDate));
        } else {}
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<ReloadState>((event, emit) async {
      emit(AuthLoading());
      try {
        emit(RolesLoaded(roles));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        final user = await loginUseCase(event.email, event.password);
        final userJson = jsonEncode(user.toJson());
        prefs.setString("user", userJson);
        currentUser = user;
        emit(Authenticated(user));
      } catch (e) {
        print("ssssssssssssssssssssss");
        print(e.toString());
        emit(AuthError(e.toString()));
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        // Attempt to sign up using the provided use case
        await signUpUseCase(event.email, event.password, event.role);

        emit(SignUpRequestedDone());
      } catch (e) {
        String errorMessage;

        // Check if the error is a FirebaseAuthException
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'email-already-in-use':
              errorMessage =
                  "The email address is already in use by another account.";
              break;
            case 'invalid-email':
              errorMessage = "The email address is not valid.";
              break;
            case 'weak-password':
              errorMessage = "The password is too weak.";
              break;
            case 'operation-not-allowed':
              errorMessage = "Email/password accounts are not enabled.";
              break;
            default:
              errorMessage = "An unknown error occurred. Please try again.";
              break;
          }
        } else {
          // Fallback for any other exception types
          errorMessage = "An unexpected error occurred. Please try again.";
        }

        // Print the actual error for debugging purposes
        print(e.toString());

        // Emit an AuthError state with a user-friendly error message
        emit(AuthError(errorMessage));
      }
    });
    on<LoadRolesRequested>((event, emit) async {
      emit(AuthLoading());
      print("??????????????  LoadRolesRequested");
      try {
        roles = await signUpUseCase.repository.fetchRoles();
        print("signUpUseCase  RolesLoaded   ${roles.toString()}");
        emit(RolesLoaded(roles));
      } catch (e) {
        print("xxxxxxxxxxxxxx  AuthError   ${e.toString()}");
        emit(AuthError('Failed to load roles'));
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('email');
        prefs.remove('password');
        prefs.setBool('rememberMe', false);
        await FirebaseAuth.instance.signOut();
        //  Get. context.pushScreen(LoginScreen());

        emit(LoggedOut());
      } catch (e) {
        emit(AuthError('Failed to sign out'));
      }
    });
  }
}

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthService _authService;
//
//   AuthBloc(this._authService) : super(AuthInitial()) {
//     on<SignInRequested>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         final user = await _authService.signInWithEmailAndPassword(
//           event.email,
//           event.password,
//         );
//         // final List<Map<String, dynamic>> historyData = [
//         //   {'date': '2024-01-25',
//         //     "kal":512,
//         //     "steps": 114141,
//         //     "pt": 0,
//         //     "distance": 1000.0,  },
//         //
//         //   {'date': '2024-09-07',
//         //     "kal":454,
//         //     "steps": 7447,
//         //     "pt": 0,
//         //     "distance": 1010.0,  },{'date': '2024-09-02',
//         //     "kal":454,
//         //     "steps": 7447,
//         //     "pt": 0,
//         //     "distance": 1400.0,  },{'date': '2024-12-02',
//         //     "kal":454,
//         //     "steps": 422,
//         //     "pt": 0,
//         //     "distance": 44.0,  },{'date': '2024-12-02',
//         //     "kal":454,
//         //     "steps": 7447,
//         //     "pt": 100,
//         //     "distance": 101.0,  },{'date': '2024-11-01',
//         //     "kal":454,
//         //     "steps": 7447,
//         //     "pt": 0,
//         //     "distance": 100.0,  },{'date': '2024-09-03',
//         //     "kal":454,
//         //     "steps": 1,
//         //     "pt": 0,
//         //     "distance": 400.0,  },{'date': '2024-09-04',
//         //     "kal":454,
//         //     "steps": 7447,
//         //     "pt": 0,
//         //     "distance": 100.0,  },{'date': '2024-09-05',
//         //     "kal":454,
//         //     "steps": 7447,
//         //     "pt": 0,
//         //     "distance": 1400.0,  },
//         //
//         //   {'date': '2024-07-06',
//         //     "kal":313,
//         //     "steps": 741,
//         //     "pt": 100,
//         //     "distance": 141.0,  },
//         //
//         // ];
//         // HistoryService().setHistoryData(historyData);
//         if (user != null) {
//           emit(Authenticated(user));
//         } else {
//           emit(AuthError('Invalid email or password'));
//         }
//       } catch (e) {
//         emit(AuthError(e.toString()));
//       }
//     });
//
//     on<SignUpRequested>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         final user = await _authService.registerWithEmailAndPassword(
//           event.email,
//           event.password,
//           event.role,
//         );
//
//         if (user != null) {
//           emit(Authenticated(user));
//         } else {
//           emit(AuthError('Failed to create account'));
//         }
//       } catch (e) {
//         emit(AuthError(e.toString()));
//       }
//     });
//

//   }
// }
