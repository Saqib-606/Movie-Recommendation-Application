import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/home/see_all_movies.dart';
import 'package:movie_recommendation_app/movie_details_screen/movie_detail_screen.dart';
import 'package:movie_recommendation_app/provider/authrization_provider.dart';
import 'package:movie_recommendation_app/provider/movie_provider.dart';
import 'package:movie_recommendation_app/provider/navigation_provider.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';
import 'package:movie_recommendation_app/widgets/movie_horizontal_list.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State <HomeTab> createState () => _HomeTabState();
}

class _HomeTabState extends State <HomeTab> {
  
  @override
  void initState () {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieProvider>().getPopularMovies();  
      context.read<MovieProvider>().getTrendingMovies();
      context.read<MovieProvider>().getTopRatedMovies();
      context.read<MovieProvider>().getUpComingMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Consumer<AuthrizationProvider>(
                  builder: (context, provider, child) {
                    return Text(
                      provider.isGuest ? "Welcome" : "Welcome, ${provider.userName ?? ""}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    );
                  }
                ),

                SizedBox(width: 5),

                Icon(Icons.waving_hand_sharp, color: Colors.amber),

                Spacer(),

                Consumer<AuthrizationProvider>(
                  builder: (context, provider, child) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: AppColors.surface2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(25))
                          ),
                          builder: (context) {
                            return SafeArea(
                              child: SizedBox(
                                height: 180,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 45,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.textPrimary
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                
                                      ListTile(
                                        leading: const Icon(Icons.photo_library),
                                        title: Text(
                                          "Change Photo",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary
                                          ),
                                        ),
                                        onTap: () async {
                                          Navigator.pop(context);
                                          await provider.pickProfileImage();
                                        },
                                      ),

                                      SizedBox(height: 5,),
                                
                                      ListTile(
                                        leading: const Icon(Icons.delete, color: Colors.red),
                                        title: Text(
                                          "Remove Photo",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary
                                          ),
                                        ),
                                        onTap: () async {
                                          Navigator.pop(context);
                                          await provider.removeProfileImage();
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );    
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: provider.profileImagePath != null ? FileImage(File(provider.profileImagePath!)) as ImageProvider :
                        provider.photoUrl != null && provider.photoUrl!.isNotEmpty ? NetworkImage(provider.photoUrl!) : null,
                        child: provider.profileImagePath == null && (provider.photoUrl == null || provider.photoUrl!.isEmpty) ?
                        const Icon(Icons.person, size: 28,) : null
                      ),
                    );
                  }
                ),
              ],
            ),

            Text(
              "What would you like to watch today?",
              style: TextStyle(color: AppColors.textSecondary,),
            ),

            SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                context.read<NavigationProvider>().updateIndex(1); 
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey,
                  )
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 45),
                      child: Text(
                        "Search movies, genres.....",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              )
            ),

            SizedBox(height: 15),

            Row(
              children: [
                Text(
                  "Trending Movies",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                Spacer(),

                TextButton(
                  onPressed: () {
                    final provider = context.read<MovieProvider>();
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SeeAllMovies(title: "Trending Movies", movies: provider.trendingMovies)
                    ));
                  },
                  child: Text("See all", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),

            SizedBox(
              height: 220,
              child: Consumer<MovieProvider>(
                builder: (context, provider, child) {
                  return provider.homeLoading ? Center(child: CircularProgressIndicator(color: Colors.white,),) : 
                  MovieHorizontalList(
                    movies: provider.trendingMovies.take(10).toList(),
                    onMovieTap: (movie) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movieId: movie.id),
                      ));
                    },
                  );
                }
              ),
            ),

            Row(
              children: [
                Text(
                  "Popular Movies",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                Spacer(),

                TextButton(
                  onPressed: () {
                    final provider = context.read<MovieProvider>();
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SeeAllMovies(title: "Popular Movies", movies: provider.popularMovies),
                    ));
                  },
                  child: Text("See all", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),

            SizedBox(
              height: 220,
              child: Consumer<MovieProvider>(
                builder: (context, provider, child) {
                  return provider.homeLoading ? Center(child: CircularProgressIndicator(color: Colors.white),) : 
                  MovieHorizontalList(
                    movies: provider.popularMovies.take(10).toList(),
                    onMovieTap: (movie) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movieId: movie.id),
                      ));
                    },
                  );
                }
              ),
            ),

            Row(
              children: [
                Text(
                  "Top Rated Movies",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                Spacer(),

                TextButton(
                  onPressed: () {
                    final provider = context.read<MovieProvider>(); 
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SeeAllMovies(title: "Top Rated Movies", movies: provider.topRatedMovies),
                    ));
                  },
                  child: Text("See all", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),

            SizedBox(
              height: 220,
              child: Consumer<MovieProvider>(
                builder: (context, provider, child) {
                  return provider.homeLoading ? Center(child: CircularProgressIndicator(color: Colors.white),) : 
                  MovieHorizontalList(
                    movies: provider.topRatedMovies.take(10).toList(),
                    onMovieTap: (movie) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movieId: movie.id),
                      ));
                    },
                  );
                }
              ),
            ),

            Row(
              children: [
                Text(
                  "Upcoming Movies",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                Spacer(),

                TextButton(
                  onPressed: () {
                    final provider = context.read<MovieProvider>();
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SeeAllMovies(title: "Upcoming Movies", movies: provider.upcomingMovies),
                    ));
                  },
                  child: Text("See all", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),

            SizedBox(
              height: 220,
              child: Consumer<MovieProvider>(
                builder: (context, provider, child) {
                  return provider.homeLoading ? Center(child: CircularProgressIndicator(color: Colors.white),) : 
                  MovieHorizontalList(
                    movies: provider.upcomingMovies.take(10).toList(),
                    onMovieTap: (movie) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movieId: movie.id),
                      ));
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}