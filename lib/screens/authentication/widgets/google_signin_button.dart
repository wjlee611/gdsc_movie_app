import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_event.dart';
import 'package:gdsc_movie_app/constants/sizes.dart';

class GoogleSigninButton extends StatelessWidget {
  const GoogleSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AuthBloc>().add(AuthGoogleSigninEvent()),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(Sizes.size20),
          boxShadow: const [
            BoxShadow(blurRadius: Sizes.size1),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: Sizes.size5),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.g_mobiledata,
              color: Colors.white,
              size: Sizes.size32,
            ),
            Text(
              'Google로 로그인',
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
