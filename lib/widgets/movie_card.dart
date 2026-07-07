import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie, required this.onTap});
  final MovieModel movie;  // Har MovieCard ke paas apni ek movie hogi.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: () {
          onTap(); 
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
        
            SizedBox(
              width: 100,
              child: Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis, 
                style: TextStyle(color: Colors.white),
              ),
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
      ),
      
    );
  }
}


