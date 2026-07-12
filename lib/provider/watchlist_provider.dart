import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/models/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchlistProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore database = FirebaseFirestore.instance;

  List<FavoriteModel> watchListMovies = [];

  static const String watchListKey = "watchlist_movies";

  Future<void> initializeWatchlist () async {
    if (auth.currentUser != null) {
      await loadUserWatchlist();
    } else {
      await loadGuestWatchlist();
    }
  }

  Future <void> loadGuestWatchlist () async { 
    watchListMovies.clear();

    final prefs = await SharedPreferences.getInstance(); 

    final String? data = prefs.getString(watchListKey);  

    if (data != null) {
      final List decodeData = jsonDecode(data);  

      watchListMovies = decodeData.map((movie) => FavoriteModel.fromJson(movie)).toList();
    }

    notifyListeners();
  }

  Future <void> saveGuestWatchlist () async { 
    final prefs = await SharedPreferences.getInstance();

    final String data = jsonEncode( 
      watchListMovies.map((movie) => movie.toJson()).toList()
    );

    await prefs.setString(watchListKey, data); 
  }

  Future <void> addWatchlist (FavoriteModel movie) async {
    watchListMovies.add(movie);

    if (auth.currentUser != null) {
      await addWatchlistToFirestore(movie);
    } else {
      await saveGuestWatchlist();
    }

    notifyListeners();
  }

  Future <void> removeWatchlist (int movieId) async {
    watchListMovies.removeWhere((movie) => movie.id == movieId);

    if (auth.currentUser != null) {
      await removeWatchlistFromFirestore(movieId);
    } else {
      await saveGuestWatchlist();
    }

    notifyListeners();
  }

  Future<void> loadUserWatchlist () async {
    final User? currentUser = auth.currentUser;

    if (currentUser == null) return;

    watchListMovies.clear();

    final QuerySnapshot<Map<String, dynamic>> snapshot = await database.collection("user").doc(currentUser.uid).collection("watchlist").get();

    watchListMovies = snapshot.docs.map((doc) => FavoriteModel.fromJson(doc.data())).toList();

    notifyListeners();
  }

  Future<void> addWatchlistToFirestore (FavoriteModel movie) async {
    final User? currentUser = auth.currentUser;

    if (currentUser == null) return;

    await database.collection("user").doc(currentUser.uid).collection("watchlist").doc(movie.id.toString()).set(movie.toJson());
  }

  Future<void> removeWatchlistFromFirestore (int movieId) async {
    final User? currentUser = auth.currentUser;

    if (currentUser == null) return;

    await database.collection("user").doc(currentUser.uid).collection("watchlist").doc(movieId.toString()).delete();
  }

  bool isWatchlisted (int movieId) {  
    return watchListMovies.any((movie) => movie.id == movieId);
  } 
}
