
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/firebase_auth.dart';
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
        await _authService.signOut();
        emit(Unauthenticated());
      } catch (e) {
        emit(AuthError('Failed to sign out'));
      }
    });
  }
}