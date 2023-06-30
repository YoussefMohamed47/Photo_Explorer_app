import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photos_project/Modules/Auth/Sign%20In/sign_in_screen.dart';
import 'package:photos_project/Modules/Home/home_screen.dart';

import '../../../Data/Provider/Local/cache_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with CacheManager {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3)).then((value) async {
        // Check if authenticated go home or go to register or sign-in
        String? userID = await getUserId();
        if (userID == null) {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  child: SignInScreen(),
                  type: PageTransitionType.rightToLeftWithFade,
                ),
                (route) => false);
          }
        } else {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  child: HomeScreen(),
                  type: PageTransitionType.rightToLeftWithFade,
                ),
                (route) => false);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.wallpaper,
          size: 100,
        ),
      ),
    );
  }
}
