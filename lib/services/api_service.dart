import 'package:dio/dio.dart';
import 'package:movie_recommendation_app/constants/api_constants.dart';
import 'package:movie_recommendation_app/models/cast_model.dart';
import 'package:movie_recommendation_app/models/movie_detail_model.dart';
import 'package:movie_recommendation_app/models/movie_model.dart';
import 'package:movie_recommendation_app/models/search_model.dart';

class ApiService {
  final Dio dio = Dio(  
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: { 
        "Authorization" : "Bearer ${ApiConstants.bearerToken}",
        "accept" : "application/json"
      }
    )
  );

  Future <List<MovieModel>> getMovies (String endpoint) async {  
    final response = await dio.get(endpoint); 
    List<MovieModel> movies = (response.data["results"] as List).map((movie) => MovieModel.fromJson(movie)).toList();
    return movies;
  }

  Future <List<MovieModel>> getPopularMovies () async { 
    return getMovies("/movie/popular");
  }

  Future <List<MovieModel>> getTrendingMovies () async { 
    return getMovies("/trending/movie/week");
  }

  Future <List<MovieModel>> getTopRatedMovies () async { 
    return getMovies("/movie/top_rated");
  }

  Future <List<MovieModel>> getUpComingMovies () async { 
    return getMovies("/movie/upcoming");
  }

  Future <MovieDetailModel> getMovieDetails (int movieId) async {
    final response = await dio.get("/movie/$movieId");
    return MovieDetailModel.fromJson(response.data);
  }

  Future <List<CastModel>> getMovieCredits (int movieId) async {
    final response = await dio.get("/movie/$movieId/credits");
    List cast = response.data["cast"];
    return cast.map((json) => CastModel.fromJson(json)).toList();
  }

  Future <List<SearchModel>> searchMovies (String query) async {
    final response = await dio.get("/search/movie", queryParameters: {"query" : query});
    List<SearchModel> movies = (response.data["results"] as List).map((movie) => SearchModel.fromJson(movie)).toList();
    return movies;
  } 
}