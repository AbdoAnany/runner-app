

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runner_app/core/helper/extension.dart';
import 'package:runner_app/features/ui/screens/home_screen.dart';

import '../../login/data/repositories/firebase_auth.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<SignInRequested>((event, emit) async {
      try {
        final user = await _authService.signInWithEmailAndPassword(
          event.email,
          event.password,
        );

        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(Unauthenticated());
        }
      } catch (_) {
        emit(Unauthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      await _authService.signOut();
      emit(Unauthenticated());
    });
    emit(AuthInitial());
  }
}