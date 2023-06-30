import 'package:flutter/material.dart';
import 'package:photos_project/Data/Models/photos.dart';
import 'package:photos_project/Modules/Wallpaper%20Details/wallpaper_details_controller.dart';
import 'package:provider/provider.dart';

class WallpaperDetailsScreen extends StatelessWidget {
  final Photos photoDetails;

  const WallpaperDetailsScreen({
    super.key,
    required this.photoDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Image.network(
            photoDetails.src!.large2x!,
            height: double.infinity,
            fit: BoxFit.cover,
            width: double.infinity,
            alignment: Alignment.center,
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
          Consumer<WallpaperDetailsController>(
            builder: (_, wallpaperDetailsController, child) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Download Img
                  wallpaperDetailsController.isDownloadingImg
                      ? const CircularProgressIndicator()
                      : CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                wallpaperDetailsController.downloadImg(
                                    photoUrl: photoDetails.src!.original!,
                                    context: context);
                              },
                              icon: const Icon(
                                Icons.download,
                                color: Colors.black,
                              )),
                        ),
                  const SizedBox(
                    width: 16,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
