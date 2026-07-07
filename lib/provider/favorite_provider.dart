import 'package:flutter/widgets.dart';
import 'package:movie_recommendation_app/models/favorite_model.dart';
import "package:shared_preferences/shared_preferences.dart";  
import 'dart:convert';  

class FavoriteProvider extends ChangeNotifier {
  List<FavoriteModel> favoriteMovies = [];

  static const String favoriteKey = "favorite_movies";

  Future <void> loadMovies () async { 
    final prefs = await SharedPreferences.getInstance(); 

    final String? data = prefs.getString(favoriteKey); 

    if (data != null) {
      final List decodeData = jsonDecode(data);  

      favoriteMovies = decodeData.map((movie) => FavoriteModel.fromJson(movie)).toList(); 
      notifyListeners();
    }
  }

  Future <void> saveMovies () async { 
    final prefs = await SharedPreferences.getInstance();

    final String data = jsonEncode( 
      favoriteMovies.map((movie) => movie.toJson()).toList()
    );

    await prefs.setString(favoriteKey, data); 
  }

  Future <void> addFavorite (FavoriteModel movie) async {
    favoriteMovies.add(movie);

    await saveMovies();

    notifyListeners();
  }

  Future <void> removeFavorite (int movieId) async {
    favoriteMovies.removeWhere((movie) => movie.id == movieId);

    await saveMovies();

    notifyListeners();
  }

  bool isFavorite (int movieId) {  
    return favoriteMovies.any((movie) => movie.id == movieId);
  } 
}