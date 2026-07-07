class SearchModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double rating;  

  SearchModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.rating,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json["id"] ?? 0, 
      title: json["title"] ?? "",  
      overview: json["overview"] ?? "", 
      posterPath: json["poster_path"] ?? "",
      backdropPath: json["backdrop_path"] ?? "",
      releaseDate: json["release_date"] ?? "",
      rating: (json["vote_average"] ?? 0).toDouble(),
    );
  }
}