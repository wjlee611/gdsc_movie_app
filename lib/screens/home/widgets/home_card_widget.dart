import 'package:flutter/material.dart';
import 'package:gdsc_movie_app/constants/gaps.dart';
import 'package:gdsc_movie_app/constants/sizes.dart';
import 'package:gdsc_movie_app/screens/home/widgets/home_movie_card_widget.dart';

class HomeCardWidget extends StatelessWidget {
  final String title;

  const HomeCardWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      margin: const EdgeInsets.only(top: Sizes.size10),
      color: Colors.black.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(Sizes.size10),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
              separatorBuilder: (context, index) => Gaps.h10,
              itemBuilder: (context, index) => HomeMovieCardWidget(
                title: (index + 1).toString(),
              ),
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
