import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:photos_project/Data/Models/photos.dart';
import 'package:photos_project/Data/Provider/API/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends ChangeNotifier {
  ApiClient apiClient = ApiClient();
  bool isLoadingImg = false;
  List<Photos> photosList = [];

  Future<bool> userLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('UID');
    FirebaseAuth user = FirebaseAuth.instance;
    await user.signOut();
    return true;
  }

  getImages() async {
    try {
      isLoadingImg = true;
      notifyListeners();
      var response = await apiClient.get('curated', param: {
        "page": 1,
        "per_page": 20,
      });
      photosList = (response!.data['photos'] as List)
          .map((photo) => Photos.fromJson(photo))
          .toList();
      notifyListeners();
      //print("TEST DIO RESPONSE ${response?.data['photos']}");
      print("photosList ${photosList}");
      print("photosList ${photosList.length}");
      isLoadingImg = false;
      notifyListeners();
    } catch (e) {
      isLoadingImg = false;
      notifyListeners();
      print("ERROR IN GETTING IMAGES ${e.toString()}");
    }
  }
}
