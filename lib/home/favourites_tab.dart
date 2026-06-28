import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/app_colors.dart';

class FavouritesTab extends StatefulWidget {
  const FavouritesTab({super.key});

  @override
  State <FavouritesTab> createState () => _FavouritesTabState();
}

class _FavouritesTabState extends State<FavouritesTab> {
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
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.favorite, color: AppColors.primary, size: 30,),
          title: Text(
            "My Favourites",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(Icons.more_horiz, color: AppColors.textPrimary,),
        ),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: movies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            childAspectRatio: 0.55
          ),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      movies[index]["image"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            
                SizedBox(height: 10),
            
                Text(
                  movies[index]["title"],
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
                      movies[index]["rating"],
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}