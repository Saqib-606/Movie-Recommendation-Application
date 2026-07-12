import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/movie_details_screen/movie_detail_screen.dart';
import 'package:movie_recommendation_app/provider/watchlist_provider.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class WatchlistTab extends StatefulWidget {
  const WatchlistTab({super.key});

  @override
  State <WatchlistTab> createState () => _FavouritesTabState();
}

class _FavouritesTabState extends State<WatchlistTab> {
  @override
  Widget build(BuildContext context) {
    final watchlistProvider = context.watch<WatchlistProvider>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        title: Text(
          "My Watchlist",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary
          ),
        ),
      ),
      body: watchlistProvider.watchListMovies.isEmpty ? 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              size: 80,
              color: Colors.grey,
            ),

            SizedBox(height: 20,),

            Text(
              "No Watchlist Yet",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),

            SizedBox(height: 10,),

            Text(
              "Start adding movies to your watchlist.",
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
          itemCount: watchlistProvider.watchListMovies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            childAspectRatio: 0.50
          ),
          itemBuilder: (context, index) {
            final movie = watchlistProvider.watchListMovies[index];
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