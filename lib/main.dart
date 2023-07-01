import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photos_project/Modules/Auth/Sign%20In/sign_in_controller.dart';
import 'package:photos_project/Modules/Auth/Sign%20In/sign_in_screen.dart';
import 'package:photos_project/Modules/Auth/Sign%20Up/sign_up_controller.dart';
import 'package:photos_project/Modules/Auth/Sign%20Up/sign_up_screen.dart';
import 'package:photos_project/Modules/Home/home_controller.dart';
import 'package:photos_project/Modules/Search%20Wallpapers/search_wallpaper_controller.dart';
import 'package:photos_project/Modules/Wallpaper%20Details/wallpaper_details_controller.dart';
import 'package:provider/provider.dart';

import 'Modules/Splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInController()),
        ChangeNotifierProvider(create: (context) => SignUpController()),
        ChangeNotifierProvider(
            create: (context) => SearchWallpaperController()),
        ChangeNotifierProvider(
            create: (context) => WallpaperDetailsController()),
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/register': (context) => const SignUpScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/login': (context) => const SignInScreen(),
        },
      ),
    ),
  );
}
