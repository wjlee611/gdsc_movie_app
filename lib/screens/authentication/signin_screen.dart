import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_state.dart';
import 'package:gdsc_movie_app/constants/gaps.dart';
import 'package:gdsc_movie_app/constants/sizes.dart';
import 'package:gdsc_movie_app/screens/authentication/widgets/google_signin_button.dart';
import 'package:go_router/go_router.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          context.replace('/signup');
        }
        if (state.status == AuthStatus.authenticated) {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Gaps.v16,
              const Text(
                'Signin for',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size20,
                ),
              ),
              const Text(
                'GDSC Movie',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v60,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(Sizes.size20),
                        topEnd: Radius.circular(Sizes.size20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(Sizes.size20),
                      child: Column(
                        children: [
                          Text(
                            'Social Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size14,
                            ),
                          ),
                          Gaps.v20,
                          GoogleSigninButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
