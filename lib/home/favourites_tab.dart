import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/movie_details_screen/movie_detail_screen.dart';
import 'package:movie_recommendation_app/provider/favorite_provider.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class FavouritesTab extends StatefulWidget {
  const FavouritesTab({super.key});

  @override
  State <FavouritesTab> createState () => _FavouritesTabState();
}

class _FavouritesTabState extends State<FavouritesTab> {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProvider>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.favorite, color: AppColors.primary, size: 30,),
          title: Text(
            "My Favorites",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: AppColors.background,
      ),
      body: favoriteProvider.favoriteMovies.isEmpty ? 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.grey,
            ),

            SizedBox(height: 20,),

            Text(
              "No Favorites Yet",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),

            SizedBox(height: 10,),

            Text(
              "Start adding movies to your favorites.",
              style: TextStyle(
                color: Colors.white60
              ),
            )
          ],
        ),
      ) 
      : Padding(
        padding: EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: favoriteProvider.favoriteMovies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            childAspectRatio: 0.50
          ),
          itemBuilder: (context, index) {
            final movie = favoriteProvider.favoriteMovies[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(movieId: movie.id),
                ));
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
                      Icon(
                        Icons.star,
                        color: Colors.deepOrangeAccent,
                        size: 15,
                      ),
              
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