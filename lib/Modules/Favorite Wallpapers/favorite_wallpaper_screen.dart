import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photos_project/Data/Models/photos.dart';
import 'package:photos_project/Data/Provider/Local/cache_manager.dart';
import 'package:photos_project/Modules/Home/home_controller.dart';
import 'package:provider/provider.dart';

import '../Wallpaper Details/wallpaper_details_screen.dart';

class FavoriteWallpapersScreen extends StatelessWidget with CacheManager {
  const FavoriteWallpapersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Provider.of<HomeController>(context, listen: false).getImages();
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('photos')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.data == null || snapshot.data!.size == 0) {
              return const Center(child: Text('No Favorite Images'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Loading"));
            }
            return GridView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                          child: WallpaperDetailsScreen(
                            photoDetails: Photos(
                              liked: true,
                              id: snapshot.data!.docs[index]['image_id'],
                              src: Src(
                                large2x: snapshot.data!.docs[index]
                                    ['image_url_large'],
                                original: snapshot.data!.docs[index]
                                    ['image_url_original'],
                              ),
                            ),
                          ),
                          type: PageTransitionType.rightToLeftWithFade,
                        ));
                  },
                  child: Image.network(
                    snapshot.data!.docs[index]['image_url_original'],
                    width: 30,
                    height: 30,
                    fit: BoxFit.fitWidth,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, object, stackTrace) {
                      return Image.asset('assets/images/image-not-found.png');
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
