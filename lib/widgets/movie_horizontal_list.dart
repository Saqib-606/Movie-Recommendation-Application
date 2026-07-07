import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/models/movie_model.dart';
import 'package:movie_recommendation_app/widgets/movie_card.dart';

class MovieHorizontalList extends StatelessWidget {
  const MovieHorizontalList({super.key,required this.movies, required this.onMovieTap});
  final List<MovieModel> movies;
  final Function(MovieModel) onMovieTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(
          movie: movie,  // Single Movie
          onTap: () {
            onMovieTap(movie);
          },
        );
      },
    );
  }
}
