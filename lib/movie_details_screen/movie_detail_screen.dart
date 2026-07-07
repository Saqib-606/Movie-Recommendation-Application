import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/main.dart';
import 'package:movie_recommendation_app/models/favorite_model.dart';
import 'package:movie_recommendation_app/provider/favorite_provider.dart';
import 'package:movie_recommendation_app/provider/movie_provider.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieId});
  final int movieId;

  @override
  State<MovieDetailScreen> createState () => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieProvider>().getMovieDetails(widget.movieId);
      context.read<MovieProvider>().getMovieCast(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          final favoriteProvider = context.watch<FavoriteProvider>();
          if (provider.detailLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.white,),);
          }
          final movie = provider.movieDetails;
          final isFavorite = favoriteProvider.isFavorite(movie!.id);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 430,
                      child: ClipRRect(
                        borderRadius: const BorderRadiusGeometry.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)
                        ),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/original${movie.backdropPath}", 
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Container(
                              color: Colors.grey.shade900,
                              child: Center(
                                child: CircularProgressIndicator(color: Colors.white,),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade900,
                              child: Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
          
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.15),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.9)
                            ]
                          )
                        ),
                      ),
                    ),
          
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
          
                SizedBox(height: 15,),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    movie.title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
          
                SizedBox(height: 15,),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                      
                      SizedBox(width: 4,),
                  
                      Text(
                        movie.rating.toStringAsFixed(1), 
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                  
                      SizedBox(width: 10,),
          
                      Text("•", style: TextStyle(color: Colors.grey)),
          
                      SizedBox(width: 10,),
                  
                      Text(
                        movie.releaseDate.isNotEmpty ? movie.releaseDate.substring(0 ,4) : "N/A", 
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                  
                      SizedBox(width: 10,),
          
                      Text("•", style: TextStyle(color: Colors.grey)),
          
                      SizedBox(width: 10,),
                  
                      Text(
                        "${movie.runtime ~/ 60}h ${movie.runtime % 60}m", 
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
          
                SizedBox(height: 15,),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: movie.genres.map((genre) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface2,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          genre.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ),
          
                SizedBox(height: 15,),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              backgroundColor: isFavorite ? AppColors.primary : AppColors.surface2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              if (isFavorite) {
                                await favoriteProvider.removeFavorite(movie.id);
                                scaffoldMessenger.currentState?.showSnackBar(SnackBar(
                                  content: Text("Removed from Favorites"),
                                ));
                              } else {
                                await favoriteProvider.addFavorite(
                                  FavoriteModel(
                                    id : movie.id,
                                    title: movie.title,
                                    rating: movie.rating,
                                    posterPath: movie.posterPath
                                  )
                                );
                                scaffoldMessenger.currentState?.showSnackBar(SnackBar(
                                  backgroundColor: AppColors.primary,
                                  content: Text("Added to Favorites"),
                                ));
                              }
                            },
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border_sharp,
                                size: 25,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Favorite",
                                  style: TextStyle(color: AppColors.textPrimary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10),
          
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              backgroundColor: AppColors.surface2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10),
                              ),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text("Feature coming soon...."),
                              ));
                            },
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.add,
                                size: 25,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Watchlist",
                                  style: TextStyle(color: AppColors.textPrimary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                SizedBox(height: 15,),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Overview",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
          
                SizedBox(height: 5,),
          
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    movie.overview,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white70,
                      height: 1.6,
                      fontSize: 15,
                    ),
                  ),
                ),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Cast",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                  
                      Spacer(),
                  
                      TextButton(
                        onPressed: () {},
                        child: Text("See all", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ),


                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    itemCount: provider.movieCast.length,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final cast = provider.movieCast[index];
                      return Container(
                        width: 110,
                        margin: const EdgeInsets.only(right: 12),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              width: 130,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: cast.profilePath.isNotEmpty ? 
                                Image.network(
                                  "https://image.tmdb.org/t/p/w500${cast.profilePath}",
                                  fit: BoxFit.cover,

                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child; 
                                    }

                                    return Center(
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,), 
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) { 
                                    return Container(
                                      color: Colors.grey.shade800,
                                      child: Center(
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    );
                                  },
                                )
                                : Container(
                                  color: Colors.grey.shade800,
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                )
                              ),
                            ),
                
                            SizedBox(height: 8,),
                
                            SizedBox(
                              width: 130,
                              child: Text(
                                cast.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                
                            SizedBox(height: 4),
                
                            SizedBox(
                              width: 130,
                              child: Text(
                                cast.character,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            )
          );
        }
      ),
    );
  }
}