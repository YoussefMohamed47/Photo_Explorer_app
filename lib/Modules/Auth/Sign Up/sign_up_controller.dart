import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photos_project/Data/Local/cache_manager.dart';

class SignUpController extends ChangeNotifier with CacheManager {
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  bool isLoadingSignUp = false;
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void changeConfirmPasswordVisibility() {
    confirmPasswordVisible = !confirmPasswordVisible;
    notifyListeners();
  }

  Future<bool> createUserWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      isLoadingSignUp = true;
      notifyListeners();
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      print('NAMES ${firstNameController.text}');
      await user!.updateDisplayName(
          '${firstNameController.text} ${lastNameController.text}');
      print('userCredential ${userCredential.user}');
      print('userCredential UID ${userCredential.user!.uid}');
      isLoadingSignUp = false;
      notifyListeners();
      await saveUserId(userID: userCredential.user!.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      isLoadingSignUp = false;
      notifyListeners();
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      isLoadingSignUp = false;
      notifyListeners();
      print("Error in creating user ${e.toString()}");
      return false;
    }
  }
}
