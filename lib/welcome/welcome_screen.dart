import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_recommendation_app/authrization/login.dart';
import 'package:movie_recommendation_app/authrization/sign_up.dart';
import 'package:movie_recommendation_app/home/home.dart';
import 'package:movie_recommendation_app/provider/BackgroundImageProvider.dart';
import 'package:movie_recommendation_app/provider/authrization_provider.dart';
import 'package:movie_recommendation_app/provider/favorite_provider.dart';
import 'package:movie_recommendation_app/provider/navigation_provider.dart';
import 'package:movie_recommendation_app/provider/watchlist_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  DateTime? _lastBackPressed;

  @override
  initState () {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<Backgroundimageprovider>();
      await provider.fetchBackgroundImages();
      provider.startAutoSlide();
    });
  }

  void _onBackPressed() {
    final now = DateTime.now();
    if (_lastBackPressed == null || now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      Fluttertoast.showToast(
        msg: "Press again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onBackPressed();
        }
      },
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Consumer<Backgroundimageprovider>(
                  builder: (context, provider, child) {
                    if (provider.backgroundImages.isEmpty) {
                      return Image.asset(
                        "assets/images/The Odyssey.jpg",
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    }
                    return AnimatedSwitcher( 
                      duration: const Duration(milliseconds: 800),
                      child:CachedNetworkImage(
                        imageUrl: provider.backgroundImages[provider.currentIndex],
                        key: ValueKey(
                          provider.backgroundImages[provider.currentIndex]
                        ),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return const Center(
                            child: CircularProgressIndicator(color: Colors.amberAccent,),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            "assets/images/The Odyssey.jpg",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ), 
                    );
                  }
                ),
              ),
      
              const SizedBox(height: 10,),
        
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amberAccent,
                          ),
                          onPressed: () {
                            context.read<NavigationProvider>().resetIndex();
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Login(),
                            ));
                          },
                          child: Text("Login", style: TextStyle(color: Colors.black87),),
                        ),
                      ),
                        
                      SizedBox(height: 15,),
                        
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade900
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ));
                          },
                          child: Text("Sign Up", style: TextStyle(color: Colors.white),),
                        ),
                      ),
                        
                      SizedBox(height: 10,),
                        
                      TextButton(
                        onPressed: () async {
                          context.read<AuthrizationProvider>().enterGuestMode();
                          await context.read<FavoriteProvider>().loadGuestFavorites();
                          await context.read<WatchlistProvider>().loadGuestWatchlist();
                          context.read<Backgroundimageprovider>().stopAutoSlide();
                          context.read<NavigationProvider>().resetIndex();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (context) => Home(),
                          ),(value) => false);
                        },
                        child: Text("Guest User", style: TextStyle(color: Colors.yellow,),),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}