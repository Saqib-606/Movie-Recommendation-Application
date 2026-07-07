import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/movie_details_screen/movie_detail_screen.dart';
import 'package:movie_recommendation_app/provider/authrization_provider.dart';
import 'package:movie_recommendation_app/provider/movie_provider.dart';
import 'package:movie_recommendation_app/provider/navigation_provider.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';
import 'package:movie_recommendation_app/widgets/movie_horizontal_list.dart';
import 'package:provider/provider.dart';

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
                      provider.isGuest ? "Hello" : "Hello, ${provider.userName ?? ""}",
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
                    return CircleAvatar(
                      radius: 25,
                      backgroundImage: provider.photoUrl != null && provider.photoUrl!.isNotEmpty ? NetworkImage(provider.photoUrl!) : null,
                      child: provider.photoUrl == null || provider.photoUrl!.isEmpty ? Icon(Icons.person, size: 28,) : null
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
                  "Trending This Week",
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

            SizedBox(
              height: 220,
              child: Consumer<MovieProvider>(
                builder: (context, provider, child) {
                  return provider.homeLoading ? Center(child: CircularProgressIndicator(color: Colors.white,),) : 
                  MovieHorizontalList(
                    movies: provider.trendingMovies,
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
                  "Movies For Your Mood",
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

            SizedBox(
              height: 220,
              child: Consumer<MovieProvider>(
                builder: (context, provider, child) {
                  return provider.homeLoading ? Center(child: CircularProgressIndicator(color: Colors.white),) : 
                  MovieHorizontalList(
                    movies: provider.popularMovies,
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
                  "Recommended For You",
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

            SizedBox(
              height: 220,
              child: Consumer<MovieProvider>(
                builder: (context, provider, child) {
                  return provider.homeLoading ? Center(child: CircularProgressIndicator(color: Colors.white),) : 
                  MovieHorizontalList(
                    movies: provider.topRatedMovies,
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
                  "Up Coming Movies",
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

            SizedBox(
              height: 220,
              child: Consumer<MovieProvider>(
                builder: (context, provider, child) {
                  return provider.homeLoading ? Center(child: CircularProgressIndicator(color: Colors.white),) : 
                  MovieHorizontalList(
                    movies: provider.upcomingMovies,
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