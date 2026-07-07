import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/movie_details_screen/movie_detail_screen.dart';
import 'package:movie_recommendation_app/provider/movie_provider.dart';
import 'package:movie_recommendation_app/provider/navigation_provider.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'dart:async'; 

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State <SearchTab> createState () => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController searchController = TextEditingController();
  Timer? debounce;  

  @override
  void dispose () {
    debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<NavigationProvider>().updateIndex(
                        0,
                      ); // Home Tab Screen
                    },
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  
                  SizedBox(width: 15,),

                  Text(
                    "Search Movies",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                ],
              ),
              
              SizedBox(height: 20,),

              TextField(
                controller: searchController,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  if (debounce?.isActive ?? false) { 
                    debounce!.cancel();
                  }

                  debounce = Timer(  
                    const Duration(milliseconds: 500),
                    () {
                      provider.searchMovie(value);
                    }
                  );
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surface2,
                  hintText: "Search Movies",
                  hintStyle: TextStyle(color: AppColors.textPrimary),
                  prefixIcon: Icon(Icons.search, color: AppColors.textPrimary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.border, width: 2),
                  )
                ),
              ),

              SizedBox(height: 20,),

              Text(
                "Search Results",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary
                ),
              ),

              SizedBox(height: 20,),

              if (provider.searchLoading)
                Center(
                  child: CircularProgressIndicator(color: Colors.white,),
                )
              else if (!provider.hasSearched) 
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Start typing to search movies",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16
                      ),
                    ),
                  ),
                )
              else if (provider.searchMovies.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      "No Movies Found",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16
                      ),
                    ),
                  ),
                )
              else        
                ListView.builder(
                  itemCount: provider.searchMovies.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => MovieDetailScreen(movieId: provider.searchMovies[index].id),
                          ));
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.surface2,
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(20),
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${provider.searchMovies[index].posterPath}",
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 100,
                                ),
                              ),
                        
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        provider.searchMovies[index].title,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                        
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Icon(
                                            Icons.star,
                                            color: AppColors.accent,
                                          ),
                                        ),
                        
                                        SizedBox(width: 1),
                        
                                        Text(
                                          provider.searchMovies[index].rating.toStringAsFixed(1),
                                          style: TextStyle(color: AppColors.textPrimary),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        
                              Padding(
                                padding: EdgeInsetsGeometry.only(right: 8),
                                child: Icon(Icons.bookmark_border, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),              
            ],
          ),
        ),
      ),
    );
  }
}
