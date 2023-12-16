import 'package:flutter/material.dart';
import 'package:gdsc_movie_app/constants/gaps.dart';
import 'package:gdsc_movie_app/constants/sizes.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: const Column(
        children: [
          Gaps.v16,
          Text(
            '프로필을 만들어봅시다!',
            style: TextStyle(
              color: Colors.white,
              fontSize: Sizes.size20,
            ),
          ),
        ],
      ),
    );
  }
}
