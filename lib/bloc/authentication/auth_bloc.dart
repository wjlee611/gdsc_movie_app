import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_event.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_state.dart';
import 'package:gdsc_movie_app/repositories/authentication/authentication_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with ChangeNotifier {
  final AuthenticationRepository authenticationRepository;

  AuthBloc({
    required this.authenticationRepository,
  }) : super(const AuthState()) {
    on<AuthInitEvent>(_authInitEventHandler);
    on<AuthGoogleSigninEvent>(_authGoogleSigninEventHandler);
    on<AuthSignoutEvent>(_authSignoutEventHandler);

    add(AuthInitEvent());
  }

  Future<void> _authInitEventHandler(
    AuthInitEvent event,
    Emitter<AuthState> emit,
  ) async {
    authenticationRepository.user.listen((user) {
      // SignOut 상태
      if (user == null) {
        emit(state.copyWith(status: AuthStatus.unknown));
      }
      // SignIn 상태
      else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }

      notifyListeners();
    });

    emit(state.copyWith(status: AuthStatus.initialized));
  }

  Future<void> _authGoogleSigninEventHandler(
    AuthGoogleSigninEvent event,
    Emitter<AuthState> emit,
  ) async {
    await authenticationRepository.signInWithGoogle();
  }

  Future<void> _authSignoutEventHandler(
    AuthSignoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await authenticationRepository.signOut();
  }
}
