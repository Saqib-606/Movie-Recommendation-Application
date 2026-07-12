import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/home/about_app.dart';
import 'package:movie_recommendation_app/home/watchlist_tab.dart';
import 'package:movie_recommendation_app/provider/favorite_provider.dart';
import 'package:movie_recommendation_app/provider/navigation_provider.dart';
import 'package:movie_recommendation_app/provider/watchlist_provider.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';
import 'package:movie_recommendation_app/provider/authrization_provider.dart';
import 'package:movie_recommendation_app/welcome/welcome_screen.dart';
import 'package:movie_recommendation_app/widgets/app_launcher.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 65),
          child: Center(
            child: Column(
              children: [
                Consumer<AuthrizationProvider>(
                  builder: (context, provider, child) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: AppColors.surface2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(25))
                          ),
                          builder: (context) {
                            return SafeArea(
                              child: SizedBox(
                                height: 180,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 45,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.textPrimary
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                
                                      ListTile(
                                        leading: const Icon(Icons.photo_library),
                                        title: Text(
                                          "Change Photo",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary
                                          ),
                                        ),
                                        onTap: () async {
                                          Navigator.pop(context);
                                          await provider.pickProfileImage();
                                        },
                                      ),

                                      SizedBox(height: 5,),
                                
                                      ListTile(
                                        leading: const Icon(Icons.delete, color: Colors.red),
                                        title: Text(
                                          "Remove Photo",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary
                                          ),
                                        ),
                                        onTap: () async {
                                          Navigator.pop(context);
                                          await provider.removeProfileImage();
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );    
                      },
                      child: SizedBox(
                        height: 110,
                        width: 110,
                        child: CircleAvatar(
                          backgroundImage: provider.profileImagePath != null ? FileImage(File(provider.profileImagePath!)) as ImageProvider :
                          provider.photoUrl != null && provider.photoUrl!.isNotEmpty ? NetworkImage(provider.photoUrl!) : null,
                          child: provider.profileImagePath == null && (provider.photoUrl == null || provider.photoUrl!.isEmpty) ?
                          const Icon(Icons.person, size: 28,) : null
                        ),
                      ),
                    );
                  }
                ),

                SizedBox(height: 15),

                Consumer<AuthrizationProvider>(
                  builder: (context, provider, child) {
                    if (provider.isGuest) {
                      return const SizedBox.shrink();
                    }
                    return Text(
                      "${provider.userName}",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                ),

                SizedBox(height: 20),

                Consumer2<FavoriteProvider, WatchlistProvider>(
                  builder: (context, favoriteProvider, watchlistProvider, child) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              height: 70,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(5),
                                  backgroundColor: AppColors.surface,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  context.read<NavigationProvider>().updateIndex(2);
                                },
                                child: Row(
                                  children: [
                                    Icon( Icons.favorite_border_sharp, size: 40, color: AppColors.primary,),

                                    SizedBox(width: 10,),

                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Favorites", style: TextStyle(color: AppColors.textPrimary),),

                                          Text(
                                            favoriteProvider.favoriteMovies.length.toString(),
                                            style: TextStyle(
                                              color: AppColors.textPrimary,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: AppColors.textSecondary,
                                      size: 30,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 10),
                    
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              height: 70,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(5),
                                  backgroundColor: AppColors.surface,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => WatchlistTab(),
                                  ));
                                },
                                child: Row(
                                  children: [
                                    Icon( Icons.bookmark_border, size: 40, color: Colors.amberAccent,),
                          
                                    SizedBox(width: 10,),
                          
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Watchlist", style: TextStyle(color: AppColors.textPrimary),),
                          
                                          Text(
                                            watchlistProvider.watchListMovies.length.toString(),
                                            style: TextStyle(
                                              color: AppColors.textPrimary,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                          
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: AppColors.textSecondary,
                                      size: 30,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                ),

                SizedBox(height: 20),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Material(  
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(15),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () async {
                            await AppLauncher.launchFeedback(context);
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.withValues(alpha: 0.18),
                            child: Icon(
                              Icons.feedback,
                              color: Colors.lightBlueAccent
                            ),
                          ),
                          title: Text("Feedback", style: TextStyle(color: AppColors.textPrimary),),
                          subtitle: Text("Share your feedback and suggestions", style: TextStyle(color: AppColors.textSecondary),),
                          trailing: Icon(Icons.chevron_right_sharp, color: AppColors.textPrimary),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: Divider(height: 0, color: AppColors.divider,),
                        ),

                        ListTile(
                          onTap: () async {
                            await AppLauncher.shareApp();                          
                          },
                          leading: CircleAvatar(
                            backgroundColor:  Colors.green.withValues(alpha: 0.18),
                            child: Icon(
                              Icons.ios_share,
                              color: Colors.greenAccent
                            ),
                          ),
                          title: Text("Share App",style: TextStyle(color: AppColors.textPrimary),),
                          subtitle: Text("Share with your friends",style: TextStyle(color: AppColors.textSecondary),),
                          trailing: Icon(Icons.chevron_right_sharp, color: AppColors.textPrimary),
                        ),
                                        
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: Divider(height: 0, color: AppColors.divider,),
                        ),

                        ListTile(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text("Feature coming soon...."),
                            ));
                          },
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF2A2418),
                            child: Icon(
                              Icons.star_rate_rounded,
                              color: Color(0xFFFFB020),
                              size: 28,
                            ),
                          ),
                          title: Text("Rate App",style: TextStyle(color: AppColors.textPrimary),),
                          subtitle: Text("Rate your experience with the app",style: TextStyle(color: AppColors.textSecondary),),
                          trailing: Icon(Icons.chevron_right_sharp, color: AppColors.textPrimary),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: Divider(height: 0, color: AppColors.divider,),
                        ),
                                        
                        ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AboutApp(),
                            ));
                          },
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF18253D), 
                            child: Icon(
                              Icons.info_outline,
                              color: Color(0xFF5B8CFF), 
                              size: 28,
                            ),
                          ),
                          title: Text("About App",style: TextStyle(color: AppColors.textPrimary),),
                          subtitle: Text("Version 1.0.0",style: TextStyle(color: AppColors.textSecondary),),
                          trailing: Icon(Icons.chevron_right_sharp, color: AppColors.textPrimary),
                        ),
                                        
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: Divider(height: 0, color: AppColors.divider,),
                        ),
                                        
                        Consumer<AuthrizationProvider>(
                          builder: (context, provider, child) {
                            return provider.loading ? Center(child: CircularProgressIndicator(),) : 
                            ListTile(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: AppColors.surface,
                                    title: Text("Log Out", style: TextStyle(color: AppColors.textPrimary),),
                                    content: Text("Do you really want to log out?", style: TextStyle(color: AppColors.textPrimary),),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          await provider.logout();
                                          await context.read<FavoriteProvider>().loadGuestFavorites();
                                          if (context.mounted) {
                                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                              builder: (context) => WelcomeScreen(),
                                            ), (value) => false);
                                          }
                                        },
                                        child: Text("Log Out", style: TextStyle(color: AppColors.textPrimary)),
                                      ),
                                        
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel", style: TextStyle(color: AppColors.textPrimary)),
                                      )
                                    ],
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                backgroundColor: Colors.red.withValues(alpha: 0.18),
                                child: Icon(
                                  Icons.logout,
                                  color: Colors.redAccent
                                ),
                              ),
                              title: Text("Log Out",style: TextStyle(color: AppColors.primary),),
                              subtitle: Text("Sign out from your account",style: TextStyle(color: AppColors.textSecondary),),
                              trailing: Icon(Icons.chevron_right_sharp, color: AppColors.textPrimary,),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}