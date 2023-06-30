import 'package:flutter/material.dart';
import 'package:photos_project/Data/Models/photos.dart';

import '../../Data/Provider/API/api.dart';

class SearchWallpaperController extends ChangeNotifier {
  ApiClient apiClient = ApiClient();
  GlobalKey<FormState> searchFormKey = GlobalKey();

  List<Photos> searchedPhotos = [];
  final TextEditingController searchController = TextEditingController();
  bool isLoadingSearch = false;

  getSearchImages({required String searchedQuote}) async {
    try {
      isLoadingSearch = true;
      notifyListeners();
      var response = await apiClient.get('search', param: {
        "query": searchedQuote,
        "per_page": 20,
      });
      searchedPhotos = (response!.data['photos'] as List)
          .map((photo) => Photos.fromJson(photo))
          .toList();
      notifyListeners();
      //print("TEST DIO RESPONSE ${response?.data['photos']}");
      print("photosList ${searchedPhotos}");
      print("photosList ${searchedPhotos.length}");
      isLoadingSearch = false;
      notifyListeners();
    } catch (e) {
      isLoadingSearch = false;
      notifyListeners();
      print("ERROR IN GETTING IMAGES ${e.toString()}");
    }
  }

  clearSearch() {
    searchController.clear();
    searchedPhotos = [];
    notifyListeners();
  }
}
