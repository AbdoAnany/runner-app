
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runner_app/core/helper/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../my_app.dart';
import '../../../../services/runner_data_service.dart';
import '../../../data/repositories/firebase_auth.dart';
import '../../pages/login_screen.dart';
import 'auth_event.dart';
import 'auth_state.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthService _authService;
//
//   AuthBloc(this._authService) : super(AuthInitial()) {
//     on<SignInRequested>((event, emit) async {
//       try {
//         final user = await _authService.signInWithEmailAndPassword(
//           event.email,
//           event.password,
//         );
//
//         if (user != null) {
//           emit(Authenticated(user));
//         } else {
//           emit(Unauthenticated());
//         }
//       } catch (_) {
//         emit(Unauthenticated());
//       }
//     });
//
//     on<SignOutRequested>((event, emit) async {
//       await _authService.signOut();
//       emit(Unauthenticated());
//     });
//     emit(AuthInitial());
//   }
// }
//
//
//
// // Events
//
// // States
//
//
// // Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _authService.signInWithEmailAndPassword(
          event.email,
          event.password,
        );
        // final List<Map<String, dynamic>> historyData = [
        //   {'date': '2024-01-25',
        //     "kal":512,
        //     "steps": 114141,
        //     "pt": 0,
        //     "distance": 1000.0,  },
        //
        //   {'date': '2024-09-07',
        //     "kal":454,
        //     "steps": 7447,
        //     "pt": 0,
        //     "distance": 1010.0,  },{'date': '2024-09-02',
        //     "kal":454,
        //     "steps": 7447,
        //     "pt": 0,
        //     "distance": 1400.0,  },{'date': '2024-12-02',
        //     "kal":454,
        //     "steps": 422,
        //     "pt": 0,
        //     "distance": 44.0,  },{'date': '2024-12-02',
        //     "kal":454,
        //     "steps": 7447,
        //     "pt": 100,
        //     "distance": 101.0,  },{'date': '2024-11-01',
        //     "kal":454,
        //     "steps": 7447,
        //     "pt": 0,
        //     "distance": 100.0,  },{'date': '2024-09-03',
        //     "kal":454,
        //     "steps": 1,
        //     "pt": 0,
        //     "distance": 400.0,  },{'date': '2024-09-04',
        //     "kal":454,
        //     "steps": 7447,
        //     "pt": 0,
        //     "distance": 100.0,  },{'date': '2024-09-05',
        //     "kal":454,
        //     "steps": 7447,
        //     "pt": 0,
        //     "distance": 1400.0,  },
        //
        //   {'date': '2024-07-06',
        //     "kal":313,
        //     "steps": 741,
        //     "pt": 100,
        //     "distance": 141.0,  },
        //
        // ];
        // HistoryService().setHistoryData(historyData);
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError('Invalid email or password'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _authService.registerWithEmailAndPassword(
          event.email,
          event.password,
          event.role,
        );

        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError('Failed to create account'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('email');
        prefs.remove('password');
        prefs.setBool('rememberMe', false);
        await _authService.signOut();
       Get. context.pushScreen(LoginScreen());

        emit(LoggedOut());
      } catch (e) {
        emit(AuthError('Failed to sign out'));
      }
    });
  }
}