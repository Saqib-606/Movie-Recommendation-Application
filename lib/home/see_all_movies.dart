import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/models/movie_model.dart';
import 'package:movie_recommendation_app/movie_details_screen/movie_detail_screen.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';

class SeeAllMovies extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;
  const SeeAllMovies({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(title,style: TextStyle(color: AppColors.textPrimary,fontWeight: FontWeight.bold,),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: movies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            childAspectRatio: 0.50,
          ),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(movieId: movie.id),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
        
                  SizedBox(height: 10),
        
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
        
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.deepOrangeAccent, size: 15),
        
                      SizedBox(width: 5),
        
                      Text(
                        movie.rating.toStringAsFixed(1),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}