import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photos_project/Modules/Search%20Wallpapers/search_wallpaper_controller.dart';
import 'package:photos_project/Widgets/custom_text_field_controller.dart';
import 'package:provider/provider.dart';

import '../Wallpaper Details/wallpaper_details_screen.dart';

class SearchWallpapersScreen extends StatefulWidget {
  const SearchWallpapersScreen({super.key});

  @override
  State<SearchWallpapersScreen> createState() => _SearchWallpapersScreenState();
}

class _SearchWallpapersScreenState extends State<SearchWallpapersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SearchWallpaperController>(context, listen: false)
          .clearSearch();
    });
  }

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<SearchWallpaperController>(
          builder: (_, searchWallpaperController, child) => Form(
            key: searchWallpaperController.searchFormKey,
            child: Column(
              children: [
                CustomTextFormField(
                  fieldController: searchWallpaperController.searchController,
                  keyboardType: TextInputType.text,
                  hintText: 'Search For Photos',
                  fieldValidator: (String? value) {
                    if (value!.isEmpty || value.length == 0) {
                      return "Please Enter Search Quote";
                    }
                  },
                  suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        if (searchWallpaperController
                            .searchFormKey.currentState!
                            .validate()) {
                          searchWallpaperController.getSearchImages(
                              searchedQuote: searchWallpaperController
                                  .searchController.text);
                        }
                      }),
                ),
                searchWallpaperController.searchedPhotos.length == 0
                    ? const Expanded(
                        child: Center(
                          child: Text("No Images"),
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount:
                              searchWallpaperController.searchedPhotos.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                      child: WallpaperDetailsScreen(
                                        photoDetails: searchWallpaperController
                                            .searchedPhotos[index],
                                      ),
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                    ));
                              },
                              child: Image.network(
                                searchWallpaperController
                                    .searchedPhotos[index].src!.original!,
                                width: 30,
                                height: 30,
                                fit: BoxFit.fitWidth,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
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
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
