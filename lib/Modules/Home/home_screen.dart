import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photos_project/Modules/Favorite%20Wallpapers/favorite_wallpaper_screen.dart';
import 'package:photos_project/Modules/Home/home_controller.dart';
import 'package:photos_project/Modules/Search%20Wallpapers/search_wallpaper_screen.dart';
import 'package:photos_project/Modules/Wallpaper%20Details/wallpaper_details_screen.dart';
import 'package:provider/provider.dart';

import '../Auth/Sign In/sign_in_screen.dart';
import 'Widgets/alert_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3)).then(
        (value) =>
            Provider.of<HomeController>(context, listen: false).getImages(),
      );
    });
  }

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
                showAlertDialog(
                  context,
                  () {
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
                  },
                );
              },
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Consumer<HomeController>(
          builder: (_, homeController, child) {
            return homeController.isLoadingImg
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: homeController.photosList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                child: WallpaperDetailsScreen(
                                  photoDetails:
                                      homeController.photosList[index],
                                ),
                                type: PageTransitionType.rightToLeftWithFade,
                              ));
                        },
                        child: Image.network(
                          homeController.photosList[index].src!.original!,
                          width: 30,
                          height: 30,
                          fit: BoxFit.fitWidth,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, object, stackTrace) {
                            return Image.asset(
                                'assets/images/image-not-found.png');
                          },
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
