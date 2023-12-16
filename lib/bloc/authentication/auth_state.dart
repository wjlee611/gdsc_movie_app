import 'package:equatable/equatable.dart';

enum AuthStatus {
  init,
  initialized, // 스트림 이벤트 핸들러 등록된 상태
  unknown, // 로그인 안 한 상태
  unauthenticated, // 로그인 했지만, 회원가입은 안된 상태
  authenticated, // 회원가입된 유저가 로그인 한 상태
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;

  const AuthState({
    this.status = AuthStatus.init,
  });

  AuthState copyWith({
    AuthStatus? status,
  }) =>
      AuthState(
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        status,
      ];
}
