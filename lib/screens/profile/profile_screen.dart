import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_bloc.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_event.dart';
import 'package:gdsc_movie_app/bloc/authentication/auth_state.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unknown) {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          centerTitle: false,
          title: const Text('Profile'),
        ),
        body: Center(
          child: Column(
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) => Column(
                  children: [
                    Text(
                      state.user?.uid ?? 'N/A',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      state.user?.email ?? 'N/A',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      state.user?.name ?? 'N/A',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    context.read<AuthBloc>().add(AuthSignoutEvent()),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
