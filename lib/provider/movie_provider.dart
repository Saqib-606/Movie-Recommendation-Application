import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/main.dart';
import 'package:movie_recommendation_app/models/cast_model.dart';
import 'package:movie_recommendation_app/models/movie_detail_model.dart';
import 'package:movie_recommendation_app/models/movie_model.dart';
import 'package:movie_recommendation_app/models/search_model.dart';
import 'package:movie_recommendation_app/services/api_service.dart';

class MovieProvider extends ChangeNotifier {
  final ApiService api = ApiService();  

  bool homeLoading = false;
  List<MovieModel> popularMovies = []; 
  List<MovieModel> trendingMovies = [];
  List<MovieModel> topRatedMovies = [];
  List<MovieModel> upcomingMovies = [];

  bool detailLoading = false;  
  MovieDetailModel ? movieDetails; 

  List<CastModel> movieCast = [];

  List<SearchModel> searchMovies = [];
  bool searchLoading = false;
  bool hasSearched = false;

  // Generic Reusable Method
  Future <void> fetchMovies (Future<List<MovieModel>> Function() apiFunction, void Function(List<MovieModel>) setter) async {
    showHomeLoading(true);
    try {  
      final movies = await apiFunction(); 
      setter(movies);
    } on DioException catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.message ?? e.toString()),
      ));
    } catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    } finally {
      showHomeLoading(false);
    }
  }

  Future<void> getMovieDetails(int movieId) async {
    showDetailLoading(true);
    try {
      movieDetails = await api.getMovieDetails(movieId);
    } on DioException catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.message ?? e.toString()),
      ));
    } catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    } finally {
      showDetailLoading(false);
    }
  }

  Future<void> getMovieCast(int movieId) async {
    showDetailLoading(true);
    try {
      movieCast = await api.getMovieCredits(movieId);
    } on DioException catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.message ?? e.toString()),
      ));
    } catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    } finally {
      showDetailLoading(false);
    }
  }

  Future<void> searchMovie(String query) async {
    if (query.trim().isEmpty) {
      hasSearched = false; 
      searchMovies.clear();
      notifyListeners();
      return;
    }
    showSearchLoading(true);
    hasSearched = true;
    try {
      searchMovies = await api.searchMovies(query);
    } on DioException catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.message ?? e.toString()),
      ));
    } catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    } finally {
      showSearchLoading(false);
    }
  }

  Future <void> getPopularMovies () {
    return fetchMovies(
      api.getPopularMovies, 
      (movies) {  
        popularMovies = movies;
      }
    );
  }

  Future <void> getTrendingMovies () {
    return fetchMovies(
      api.getTrendingMovies,  
      (movies) {  
        trendingMovies = movies;
      }
    );
  }

  Future <void> getTopRatedMovies () {
    return fetchMovies(
      api.getTopRatedMovies, 
      (movies) {  
        topRatedMovies = movies;
      }
    );
  }

  Future <void> getUpComingMovies () {
    return fetchMovies(
      api.getUpComingMovies,  
      (movies) {  
        upcomingMovies = movies;
      }
    );
  }

  void showHomeLoading (bool value) {
    homeLoading = value;
    notifyListeners();
  }

  void showDetailLoading (bool value) {
    detailLoading = value;
    notifyListeners();
  }

  void showSearchLoading (bool value) {
    searchLoading = value;
    notifyListeners();
  }
}