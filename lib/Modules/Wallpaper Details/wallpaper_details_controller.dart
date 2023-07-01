import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class WallpaperDetailsController extends ChangeNotifier {
  bool isDownloadingImg = false;
  void update() {
    notifyListeners();
  }

  void downloadImg(
      {required String photoUrl, required BuildContext context}) async {
    isDownloadingImg = true;
    notifyListeners();
    await GallerySaver.saveImage(photoUrl).then((bool? success) {
      if (success!) {
        isDownloadingImg = false;
        notifyListeners();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Image Is Saved')));
      } else {
        isDownloadingImg = false;
        notifyListeners();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('There is Issue')));
      }
    });
  }
}
