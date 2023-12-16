import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/bloc/home/home_movies_bloc.dart';
import 'package:gdsc_movie_app/bloc/search/search_movies_bloc.dart';
import 'package:gdsc_movie_app/firebase_options.dart';
import 'package:gdsc_movie_app/repositories/tmdb/tmdb_movie_repository.dart';
import 'package:gdsc_movie_app/screens/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TMDBMovieRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeMoviesBloc(
              tmdbMovieRepository: context.read<TMDBMovieRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SearchMoviesBloc(
              tmdbMovieRepository: context.read<TMDBMovieRepository>(),
            ),
          )
        ],
        child: const AppRouter(),
      ),
    );
  }
}
