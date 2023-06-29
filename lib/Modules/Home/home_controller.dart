import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends ChangeNotifier {
  Future<bool> userLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('UID');
    FirebaseAuth user = FirebaseAuth.instance;
    await user.signOut();
    return true;
  }
}
