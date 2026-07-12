import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_recommendation_app/models/favorite_model.dart';
import "package:shared_preferences/shared_preferences.dart"; 
import 'dart:convert'; 

class FavoriteProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore database = FirebaseFirestore.instance;
  List<FavoriteModel> favoriteMovies = [];
  static const String favoriteKey = "favorite_movies";

  Future<void> initializeFavorites () async { 
    if (auth.currentUser != null) { 
      await loadUserFavorites();
    } else {
      await loadGuestFavorites();
    }
  }

  Future <void> loadGuestFavorites () async { 
    favoriteMovies.clear();

    final prefs = await SharedPreferences.getInstance(); 

    final String? data = prefs.getString(favoriteKey); 

    if (data != null) {
      final List decodeData = jsonDecode(data);  

      favoriteMovies = decodeData.map((movie) => FavoriteModel.fromJson(movie)).toList(); 
    }

    notifyListeners();
  }

  Future <void> saveGuestFavorites () async { 
    final prefs = await SharedPreferences.getInstance();

    final String data = jsonEncode( 
      favoriteMovies.map((movie) => movie.toJson()).toList()
    );

    await prefs.setString(favoriteKey, data); 
  }

  Future <void> addFavorite (FavoriteModel movie) async {
    favoriteMovies.add(movie);

    if (auth.currentUser != null) {
      await addFavoriteToFirestore(movie);
    } else {
      await saveGuestFavorites();  // Guest User
    }

    notifyListeners();
  }

  Future <void> removeFavorite (int movieId) async {
    favoriteMovies.removeWhere((movie) => movie.id == movieId);

    if (auth.currentUser != null) {
      await removeFavoriteFromFirestore(movieId);
    } else {
      await saveGuestFavorites();
    }
    
    notifyListeners();
  }

  Future<void> loadUserFavorites () async {
    final User? currentUser = auth.currentUser;

    if (currentUser == null) return;

    favoriteMovies.clear();

    final QuerySnapshot<Map<String, dynamic>> snapshot = await database.collection("user").doc(currentUser.uid).collection("favorites").get();

    favoriteMovies = snapshot.docs.map((doc) => FavoriteModel.fromJson(doc.data())).toList(); 

    notifyListeners();
  }

  Future<void> addFavoriteToFirestore (FavoriteModel movie) async {
    final User? currentUser = auth.currentUser;  

    if (currentUser == null) return;  

    await database.collection("user").doc(currentUser.uid).collection("favorites").doc(movie.id.toString()).set(movie.toJson());
  }

  Future<void> removeFavoriteFromFirestore (int movieId) async {
    final User? currentUser = auth.currentUser;

    if (currentUser == null) return;

    await database.collection("user").doc(currentUser.uid).collection("favorites").doc(movieId.toString()).delete();
  }

  bool isFavorite (int movieId) {  
    return favoriteMovies.any((movie) => movie.id == movieId);
  } 
}