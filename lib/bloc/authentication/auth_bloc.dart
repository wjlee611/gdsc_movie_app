import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_event.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_state.dart';
import 'package:gdsc_movie_app/repositories/firebase/authentication_repository.dart';
import 'package:gdsc_movie_app/repositories/firebase/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  AuthBloc({
    required this.authenticationRepository,
    required this.userRepository,
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
    await _updateAuthState(emit);
  }

  Future<void> _authGoogleSigninEventHandler(
    AuthGoogleSigninEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await authenticationRepository.signInWithGoogle();

      await _updateAuthState(emit);
    } catch (_) {}
  }

  Future<void> _updateAuthState(
    Emitter<AuthState> emit,
  ) async {
    final user = await authenticationRepository.user.first;

    // SignOut 상태
    if (user == null) {
      emit(state.copyWith(status: AuthStatus.unknown));
    } else {
      // SignIn 상태
      final result = await userRepository.findUser(user.uid!);
      // 회원가입 안 한 유저
      if (result == null) {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          user: user,
        ));
      }
      // 회원가입 한 유저
      else {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: result,
        ));
      }
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
    } catch (_) {}
  }
}
