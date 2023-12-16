import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_event.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_state.dart';
import 'package:gdsc_movie_app/repositories/authentication/authentication_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
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
    final user = await authenticationRepository.user.first;

    // SignOut 상태
    if (user == null) {
      emit(state.copyWith(status: AuthStatus.unknown));
    }
    // SignIn 상태
    else {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        user: user,
      ));
    }
  }

  Future<void> _authGoogleSigninEventHandler(
    AuthGoogleSigninEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await authenticationRepository.signInWithGoogle();
      final user = await authenticationRepository.user.first;
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        user: user,
      ));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _authSignoutEventHandler(
    AuthSignoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await authenticationRepository.signOut();
      emit(state.copyWith(
        status: AuthStatus.unknown,
        user: null,
      ));
    } catch (e) {
      print(e);
    }
  }
}
