import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/provider/BackgroundImageProvider.dart';
import 'package:movie_recommendation_app/provider/authrization_provider.dart';
import 'package:movie_recommendation_app/provider/favorite_provider.dart';
import 'package:movie_recommendation_app/provider/movie_provider.dart';
import 'package:movie_recommendation_app/provider/navigation_provider.dart';
import 'package:movie_recommendation_app/provider/watchlist_provider.dart';
import 'package:movie_recommendation_app/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

final scaffoldMessenger = GlobalKey <ScaffoldMessengerState> (); 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ 
        ChangeNotifierProvider(create: (context) => AuthrizationProvider()..loadProfileImage(),), 
        ChangeNotifierProvider(create: (context) => MovieProvider(),),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()..initializeFavorites()),
        ChangeNotifierProvider(create: (context) => WatchlistProvider()..initializeWatchlist()),
        ChangeNotifierProvider(create: (context) => NavigationProvider(),),
        ChangeNotifierProvider(create: (context) => Backgroundimageprovider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        scaffoldMessengerKey: scaffoldMessenger,
      ),
    );
  }
}