import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_state.dart';
import 'package:gdsc_movie_app/bloc/splash/splash_cubit.dart';
import 'package:gdsc_movie_app/bloc/splash/test_load_data_cubit.dart';
import 'package:gdsc_movie_app/constants/gaps.dart';
import 'package:gdsc_movie_app/enums/common_loading_type.dart';
import 'package:gdsc_movie_app/widgets/common_loading_widget.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status != AuthStatus.init) {
              context.read<TestLoadDataCubit>().loadingData();
              context
                  .read<SplashCubit>()
                  .changeStatus(SplashStatus.otherDataLoad);
            }
          },
        ),
        BlocListener<TestLoadDataCubit, CommonLoadingType>(
          listener: (context, state) {
            if (state == CommonLoadingType.loaded) {
              context.go('/home');
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<SplashCubit, SplashStatus>(
                builder: (context, state) => Text(
                  state.message,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Gaps.v10,
              const CommonLoadingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
