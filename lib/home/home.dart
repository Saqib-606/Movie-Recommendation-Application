import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_recommendation_app/utils/app_colors.dart';
import 'package:movie_recommendation_app/home/favourites_tab.dart';
import 'package:movie_recommendation_app/home/home_tab.dart';
import 'package:movie_recommendation_app/home/profile_tab.dart';
import 'package:movie_recommendation_app/home/search_tab.dart';
import 'package:movie_recommendation_app/provider/navigation_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State <Home> createState () => _HomeState();
}

class _HomeState extends State <Home> {
  late final List<Widget> screens;
  DateTime? _lastBackPressed;

  void _onBackPressed () {
    final now = DateTime.now();

    if (_lastBackPressed == null || now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      Fluttertoast.showToast(
        msg: "Press again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM
      );

      return;
    }
    SystemNavigator.pop();
  }

  @override
  void initState() {
    super.initState();
    screens = [
      HomeTab(), // Index 0
      SearchTab(), // Index 1
      FavouritesTab(), 
      ProfileTab()  
    ];
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
        backgroundColor: AppColors.background,
        body: Consumer<NavigationProvider>(
          builder: (_, provider, _) {
            return SafeArea(
              child: IndexedStack( 
                index: provider.currentIndex,
                children: screens,
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(
                top: BorderSide(
                  color: AppColors.border,
                  width: 1
                )
              )
            ),
            child: Consumer<NavigationProvider>(
              builder: (context, provider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero, // Removes internal padding
                          constraints: BoxConstraints(), // Overrides default 48x48 constraints
                          style: ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrinks touch target to minimum size
                          ),
                          onPressed: () {
                            provider.updateIndex(0);
                          },
                          icon: Icon(
                            Icons.home,
                            color: provider.currentIndex == 0 ? AppColors.primary : AppColors.textSecondary,
                          ),
                        ),
      
                        Text(
                          "Home",
                          style: TextStyle(
                            color: provider.currentIndex == 0 ? AppColors.primary : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
      
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          style: ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            provider.updateIndex(1);
                          },
                          icon: Icon(
                            Icons.search,
                            color: provider.currentIndex == 1 ? AppColors.primary : AppColors.textSecondary,
                          ),
                        ),
      
                        Text(
                          "Search",
                          style: TextStyle(
                            color: provider.currentIndex == 1 ? AppColors.primary : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
      
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          style: ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            provider.updateIndex(2);
                          },
                          icon: Icon(
                            Icons.favorite_border,
                            color: provider.currentIndex == 2 ? AppColors.primary : AppColors.textSecondary,
                          ),
                        ),
      
                        Text(
                          "Favorites",
                          style: TextStyle(
                            color: provider.currentIndex == 2 ? AppColors.primary : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
      
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          style: ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            provider.updateIndex(3);
                          },
                          icon: Icon(
                            Icons.person,
                            color: provider.currentIndex == 3 ? AppColors.primary : AppColors.textSecondary,
                          ),
                        ),
      
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: provider.currentIndex == 3 ? AppColors.primary : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}