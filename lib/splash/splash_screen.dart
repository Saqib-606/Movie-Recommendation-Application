import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/home/home.dart';
import 'package:movie_recommendation_app/provider/authrization_provider.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';
import 'package:movie_recommendation_app/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override 
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  void nextScreen() async {
    await Future.delayed(Duration(seconds: 3));

    if (auth.currentUser == null) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
          (value) => false,
        );
      }
    } else {
      if (mounted) {
        await context.read<AuthrizationProvider>().getCurrentUserData();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
          (value) => false,
        );
      }
    }
  }

  @override
  void initState() {
    nextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/Logo.png",
              height: 160,
              width: 160,
              fit: BoxFit.contain,
            ),

            Text(
              "MovieVerse",
              style: TextStyle(
                fontSize: 36,
                fontFamily: 'Times New Roman',
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: AppColors.textPrimary,
                letterSpacing: 1
              ),
            ),

            const SizedBox(height: 5,),

            Text(
              "Discover Your Next Movie",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Times New Roman',
                fontStyle: FontStyle.italic,
                color: AppColors.textSecondary,
                letterSpacing: 0.5,
              ),
            )      
          ],
        )
      )
    );
  }
}