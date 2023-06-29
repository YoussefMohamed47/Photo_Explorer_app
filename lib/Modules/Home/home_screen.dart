import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photos_project/Modules/Favorite%20Wallpapers/favorite_wallpaper_screen.dart';
import 'package:photos_project/Modules/Home/Widgets/alert_dialog.dart';
import 'package:photos_project/Modules/Home/home_controller.dart';
import 'package:photos_project/Modules/Search%20Wallpapers/search_wallpaper_screen.dart';
import 'package:provider/provider.dart';

import '../Auth/Sign In/sign_in_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: SearchWallpapersScreen(),
                      type: PageTransitionType.rightToLeftWithFade));
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: FavoriteWallpapersScreen(),
                      type: PageTransitionType.rightToLeftWithFade));
            },
            icon: Icon(Icons.favorite),
          ),
          Consumer<HomeController>(
            builder: (_, homeController, child) => IconButton(
              onPressed: () {
                showAlertDialog(context, () {
                  homeController.userLogout().then(
                    (value) {
                      if (value == true) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                              child: SignInScreen(),
                              type: PageTransitionType.rightToLeftWithFade,
                            ),
                            (route) => false);
                      }
                    },
                  );
                });
              },
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
