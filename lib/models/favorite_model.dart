class FavoriteModel {
  final int id;
  final String title;
  final String posterPath;
  final double rating;

  FavoriteModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "posterPath": posterPath,
      "rating": rating,
    };
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json["id"],
      title: json["title"],
      posterPath: json["posterPath"],
      rating: (json["rating"] as num).toDouble(),
    );
  }
}