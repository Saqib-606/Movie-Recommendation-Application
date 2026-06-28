import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/app_colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State <HomeTab> createState () => _HomeTabState();
}

class _HomeTabState extends State <HomeTab> {
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
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Hello, Saqi",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                SizedBox(width: 5),

                Icon(Icons.waving_hand_sharp, color: Colors.amber),

                Spacer(),

                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/Bio.png",
                      ),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ],
            ),

            Text(
              "What would you like to watch today?",
              style: TextStyle(color: AppColors.textSecondary,),
            ),

            SizedBox(height: 20),

            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surface2,
                hintText: "Search movies, genres.....",
                hintStyle: TextStyle(color: AppColors.textSecondary),
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
                ),
              ),
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
              height: 210,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Column(
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
                    ),
                  );
                },
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
              height: 210,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Column(
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
                    ),
                  );
                },
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
              height: 210,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Column(
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}