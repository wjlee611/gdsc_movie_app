import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/enums/common_loading_type.dart';

class TestLoadDataCubit extends Cubit<CommonLoadingType> {
  TestLoadDataCubit() : super(CommonLoadingType.init);

  Future<void> loadingData() async {
    emit(CommonLoadingType.loading);
    await Future.delayed(const Duration(seconds: 1));
    emit(CommonLoadingType.loaded);
  }
}
