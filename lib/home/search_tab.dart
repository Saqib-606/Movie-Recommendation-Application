import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/app_colors.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State <SearchTab> createState () => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController searchController = TextEditingController();
  List <Map<String, dynamic>> movies = [
    {
      "title" : "The Northman",
      "rating" : "8.5",
      "image" : "assets/images/The Northman.jpg" 
    },

    {
      "title" : "The Northman 2",
      "rating" : "6.5",
      "image" : "assets/images/The Northman 2.jpg"
    },

    {
      "title" : "The Odyssey",
      "rating" : "9.5",
      "image" : "assets/images/The Odyssey.jpg"
    },

    {
      "title" : "The Odyssey 2",
      "rating" : "8.2",
      "image" : "assets/images/The Odyssey 2.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "Search Movies",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
        ),
        // centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surface2,
                  hintText: "Search for Movies",
                  hintStyle: TextStyle(color: AppColors.textSecondary),
                  prefixIcon: Icon(Icons.search, color: AppColors.textPrimary,),
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
                "Popular Searches",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(height: 10,),

              Row(
                children: [
                  Container(
                    height: 35,
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.surface2,
                    ),
                    child: Center(
                      child: Text(
                        "Avengers",
                        style: TextStyle(
                          color: AppColors.textPrimary
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 7,),

                  Container(
                    height: 35,
                    width: 87,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.surface2,
                    ),
                    child: Center(
                      child: Text(
                        "Spider-Man",
                        style: TextStyle(
                          color: AppColors.textPrimary
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 7,),

                  Container(
                    height: 35,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.surface2,
                    ),
                    child: Center(
                      child: Text(
                        "Batman",
                        style: TextStyle(
                          color: AppColors.textPrimary
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 7,),

                  Container(
                    height: 35,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.surface2,
                    ),
                    child: Center(
                      child: Text(
                        "Inception",
                        style: TextStyle(
                          color: AppColors.textPrimary
                        ),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: 10,),

              Row(
                children: [
                  Container(
                    height: 35,
                    width: 88,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.surface2,
                    ),
                    child: Center(
                      child: Text(
                        "Interstallar",
                        style: TextStyle(
                          color: AppColors.textPrimary
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 7,),

                  Container(
                    height: 35,
                    width: 92,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.surface2,
                    ),
                    child: Center(
                      child: Text(
                        "Harry-Potter",
                        style: TextStyle(
                          color: AppColors.textPrimary
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25,),

              Text(
                "Search Results",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary
                ),
              ),

              SizedBox(height: 10,),

              ListView.builder(
                itemCount: movies.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // color: Colors.grey[850],
                        color: AppColors.surface2,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(20),
                            child: Image.asset(
                              movies[index]["image"],
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
                                    movies[index]["title"],
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
                                      movies[index]["rating"],
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