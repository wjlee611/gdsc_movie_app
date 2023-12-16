import 'package:equatable/equatable.dart';
import 'package:gdsc_movie_app/models/user/user_model.dart';

enum AuthStatus {
  init,
  unknown, // 로그인 안 한 상태
  unauthenticated, // 로그인 했지만, 회원가입은 안된 상태
  authenticated, // 회원가입된 유저가 로그인 한 상태
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserModel? user;

  const AuthState({
    this.status = AuthStatus.init,
    this.user,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
  }) =>
      AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [
        status,
        user,
      ];
}
