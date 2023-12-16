import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashStatus {
  initalizeFirebaseAuth('초기화 중입니다...'),
  otherDataLoad('데이터 로딩 중입니다...');

  final String message;

  const SplashStatus(this.message);
}

class SplashCubit extends Cubit<SplashStatus> {
  SplashCubit() : super(SplashStatus.initalizeFirebaseAuth);

  changeStatus(SplashStatus status) => emit(status);
}
