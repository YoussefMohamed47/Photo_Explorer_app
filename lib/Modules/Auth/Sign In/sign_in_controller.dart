import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photos_project/Data/Local/cache_manager.dart';

class SignInController extends ChangeNotifier with CacheManager {
  GlobalKey<FormState> signInFormKey = GlobalKey();
  bool isLoadingSignIn = false;
  bool passwordVisible = true;
  final TextEditingController signInEmailController = TextEditingController();
  final TextEditingController signInPasswordController =
      TextEditingController();

  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  Future<bool> signInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      isLoadingSignIn = true;
      notifyListeners();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isLoadingSignIn = false;
      notifyListeners();
      await saveUserId(userID: userCredential.user!.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      isLoadingSignIn = false;
      notifyListeners();
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for that email.')));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong password provided for that user.')));
        print('Wrong password provided for that user.');
      }
      return false;
    } catch (e) {
      isLoadingSignIn = false;
      notifyListeners();

      print("Error In Sign In");
      return false;
    }
  }
}
