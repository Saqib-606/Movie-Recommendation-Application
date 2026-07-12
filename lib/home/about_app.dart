import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});
  @override
  State<AboutApp> createState () => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        title: Text("About App", style: TextStyle(color: AppColors.textPrimary),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/Logo.png",
                  ),
                  fit: BoxFit.cover
                )
              ),
            ),
                
            Text(
              "MovieVerse",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary
              ),
            ),
        
            SizedBox(height: 5,),
        
            Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.surface2
              ),
              child: Center(
                child: Text("v1.0.0", style: TextStyle(color: AppColors.textPrimary),),
              ),
            ),
        
            SizedBox(height: 5,),
        
            SizedBox(
              width: 290,
              child: Text(
                "Discover trending movies, search titles, manage favorites, and create your watchlist",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, height: 1.5),
              ),
            ),
        
            SizedBox(height: 20,),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(height: 0, color: AppColors.divider),
            ),
        
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.withValues(alpha: 0.18),
                child: Icon(Icons.person_outline, color: Colors.deepPurpleAccent,),
              ),
              title: Text("Developed By",style: TextStyle(color: AppColors.textPrimary),),
              subtitle: Text("Saqib",style: TextStyle(color: AppColors.textSecondary),),
            ),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(height: 0, color: AppColors.divider),
            ),
        
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.withValues(alpha: 0.18),
                child: Icon(Icons.code, color: Colors.lightBlueAccent,),
              ),
              title: Text("Built With",style: TextStyle(color: AppColors.textPrimary),),
              subtitle: Text("Flutter • Firebase",style: TextStyle(color: AppColors.textSecondary),),
            ),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(height: 0, color: AppColors.divider),
            ),
        
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red.withValues(alpha: 0.18),
                child: Icon(Icons.movie_creation_outlined, color: Colors.redAccent,),
              ),
              title: Text("Movie Data",style: TextStyle(color: AppColors.textPrimary),),
              subtitle: Text("TMDB API",style: TextStyle(color: AppColors.textSecondary),),
            ),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(height: 0, color: AppColors.divider),
            ),
        
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.withValues(alpha: 0.18),
                child: Icon(Icons.verified_outlined, color: Colors.greenAccent,),
              ),
              title: Text("Version",style: TextStyle(color: AppColors.textPrimary),),
              subtitle: Text("1.0.0",style: TextStyle(color: AppColors.textSecondary),),
            ),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(height: 0, color: AppColors.divider),
            ),
        
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange.withValues(alpha: 0.18),
                child: Icon(Icons.calendar_month_outlined, color: Colors.orangeAccent,),
              ),
              title: Text("Release Year",style: TextStyle(color: AppColors.textPrimary),),
              subtitle: Text("2026",style: TextStyle(color: AppColors.textSecondary),),
            ),
        
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.surface
              ),
              child: ListTile(
                leading: Icon(Icons.favorite, color: Colors.white,),
                title: Text("Thank you for using the app!", style: TextStyle(color: AppColors.textPrimary),),
                subtitle: Text("I hope you enjoy discovering greate movies.", style: TextStyle(color: AppColors.textSecondary),),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 30,
          alignment: Alignment.center,
          child: Text(
            "© 2026 Saqib. All rights reserved.",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13
            ),
          ),
        ),
      ),
    );
  }
}