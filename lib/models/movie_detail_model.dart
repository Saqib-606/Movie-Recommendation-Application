import 'package:movie_recommendation_app/models/genre_model.dart';

class MovieDetailModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double rating;
  final int runtime;
  final List<GenreModel> genres;

  MovieDetailModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.rating,
    required this.runtime,
    required this.genres,
  });

  factory MovieDetailModel.fromJson (Map<String, dynamic> json) {
    return MovieDetailModel (
      id : json["id"] ?? 0,
      title : json["title"] ?? "",
      overview: json["overview"] ?? "",  
      posterPath: json["poster_path"] ?? "",
      backdropPath: json["backdrop_path"] ?? "",
      releaseDate: json["release_date"] ?? "",
      runtime: (json["runtime"] ?? 0),
      rating: (json["vote_average"] ?? 0).toDouble(),
      genres: (json["genres"] as List).map((genre) => GenreModel.fromJson(genre)).toList(),
    );
  }
}