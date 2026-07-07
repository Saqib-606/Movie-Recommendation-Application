import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/provider/favorite_provider.dart';
import 'package:movie_recommendation_app/provider/navigation_provider.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';
import 'package:movie_recommendation_app/provider/authrization_provider.dart';
import 'package:movie_recommendation_app/welcome/welcome_screen.dart';
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
          padding: EdgeInsets.only(top: 40),
          child: Center(
            child: Column(
              children: [
                Container(  
                  height: 110,
                  width: 110,
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

                SizedBox(height: 15),

                Text(
                  "Saqi",
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "Flutter Developer",
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
                ),

                SizedBox(height: 20),

                Consumer<FavoriteProvider>(
                  builder: (context, provider, child) {
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
                                            provider.favoriteMovies.length.toString(),
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
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text("Feature coming soon...."),
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
                                            "!",
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
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text("Feature coming soon...."),
                            ));
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurple.withValues(alpha: 0.18),
                            child: Icon(
                              Icons.notifications_outlined,
                              color: Colors.deepPurpleAccent
                            ),
                          ),
                          title: Text("Notifications",style: TextStyle(color: AppColors.textPrimary),),
                          subtitle: Text("Manage your alerts",style: TextStyle(color: AppColors.textSecondary),),
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
                            backgroundColor: Colors.blue.withValues(alpha: 0.18),
                            child: Icon(
                              Icons.settings,
                              color: Colors.lightBlueAccent
                            ),
                          ),
                          title: Text("Settings", style: TextStyle(color: AppColors.textPrimary),),
                          subtitle: Text("App preferences & more", style: TextStyle(color: AppColors.textSecondary),),
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
                            backgroundColor: Colors.orange.withValues(alpha: 0.18),
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.orangeAccent
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