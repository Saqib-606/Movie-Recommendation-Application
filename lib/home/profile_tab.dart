import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/app_colors.dart';
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
          padding: EdgeInsets.only(top: 50),
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

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(5),
                              backgroundColor: AppColors.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border_sharp,
                              size: 45,
                              color: AppColors.primary,
                            ),
                            label: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Favorties",
                                  style: TextStyle(color: AppColors.textPrimary),
                                ),
                                Text(
                                  "25",
                                  style: TextStyle(color: AppColors.textPrimary),
                                ),
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
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(5),
                              backgroundColor: AppColors.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_border,
                              size: 45,
                              color: AppColors.accent,
                            ),
                            label: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Watchlist",
                                  style: TextStyle(color: AppColors.textPrimary),
                                ),
                                Text(
                                  "14",
                                  style: TextStyle(color: AppColors.textPrimary,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          onTap: (){
                                        
                          },
                          leading: Icon(Icons.refresh, color: AppColors.textPrimary),
                          title: Text(
                            "Watch History",
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                          trailing: Icon(Icons.chevron_right_sharp, color: AppColors.textPrimary),
                        ),
                                        
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: Divider(height: 0, color: AppColors.divider,),
                        ),
                        
                                        
                        ListTile(
                          onTap: () {
                            
                          },
                          leading: Icon(Icons.file_download_outlined, color: AppColors.textPrimary),
                          title: Text(
                            "Downloads",
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                          trailing: Icon(Icons.chevron_right_sharp, color: AppColors.textPrimary),
                        ),
                                        
                        
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: Divider(height: 0, color: AppColors.divider,),
                        ),
                                        
                        ListTile(
                          onTap: () {
                            
                          },
                          leading: Icon(Icons.mood, color: AppColors.textPrimary),
                          title: Text(
                            "Mood Preferences",
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                          trailing: Icon(Icons.chevron_right_sharp, color: AppColors.textPrimary),
                        ),
                                        
                        
                         Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: Divider(height: 0, color: AppColors.divider,),
                        ),
                                        
                        ListTile(
                          onTap: () {
                            
                          },
                          leading: Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
                          title: Text(
                            "Notification",
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                          trailing: Icon(Icons.chevron_right_sharp, color: AppColors.textPrimary),
                        ),
                                        
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: Divider(height: 0, color: AppColors.divider,),
                        ),
                                        
                        ListTile(
                          onTap: () {
                            
                          },
                          leading: Icon(Icons.settings, color: AppColors.textPrimary),
                          title: Text(
                            "Settings",
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
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
                              leading: Icon(Icons.logout, color: AppColors.primary),
                              title: Text(
                                "Log Out",
                                style: TextStyle(
                                  color: AppColors.primary
                                ),
                              ),
                              trailing: Icon(Icons.chevron_right_sharp, color: Colors.white),
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