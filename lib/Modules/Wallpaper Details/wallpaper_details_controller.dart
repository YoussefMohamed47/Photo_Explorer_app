import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:photos_project/Data/Models/photos.dart';
import 'package:photos_project/Data/Provider/Local/cache_manager.dart';

class WallpaperDetailsController extends ChangeNotifier with CacheManager {
  bool isDownloadingImg = false;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void update({required Photos photoDetail, required favOrNot}) async {
    String? docId = await getUserId();
    try {
      if (favOrNot) {
        users.doc(docId).collection('photos').add({
          'image_id': photoDetail.id,
          'image_url_original': photoDetail.src!.original,
          'image_url_large': photoDetail.src!.large2x,
        });
      } else {
        users
            .doc(docId)
            .collection('photos')
            .where('image_id', isEqualTo: photoDetail.id)
            .get()
            .then((value) {
          value.docs[0].reference.delete();
        });
      }
    } catch (e) {
      print("Error ssss ${e.toString()}");
    }
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
