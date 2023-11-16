import 'package:flutter/material.dart';
import 'package:gdsc_movie_app/widgets/common_input_widget.dart';

class SearchScreen extends StatelessWidget {
  final String? initValue;

  const SearchScreen({
    super.key,
    this.initValue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        centerTitle: false,
        title: CommonInputWidget(
          initValue: initValue,
          padding: EdgeInsets.zero,
        ),
      ),
      body: const Center(
        child: Text(
          'Profile screen',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
