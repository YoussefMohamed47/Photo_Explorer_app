import 'package:shared_preferences/shared_preferences.dart';

mixin CacheManager {
  Future<bool> saveUserId({required String userID}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('UID', userID);
    return true;
  }

  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('UID');
  }
}
