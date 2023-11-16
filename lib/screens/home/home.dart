import 'package:flutter/material.dart';
import 'package:gdsc_movie_app/repositories/tmdb/tmdb_movie_repository.dart';
import 'package:gdsc_movie_app/screens/home/widgets/home_card_widget.dart';
import 'package:gdsc_movie_app/screens/home/widgets/home_sliver_appbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TMDBMovieRepository _repository = TMDBMovieRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: CustomScrollView(
        slivers: [
          const HomeSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                HomeCardWidget(
                  title: '현재 상영 중',
                  futureFunction: _repository.getNowPlaying,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.bottom),
          ),
        ],
      ),
    );
  }
}
