import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photos_project/Modules/Auth/Sign%20In/sign_in_controller.dart';
import 'package:photos_project/Modules/Auth/Sign%20Up/sign_up_screen.dart';
import 'package:provider/provider.dart';

import '../../../Widgets/custom_text_field_controller.dart';
import '../../Home/home_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Consumer<SignInController>(
            builder: (_, signInController, child) {
              return Form(
                key: signInController.signInFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Email
                    CustomTextFormField(
                      fieldController: signInController.signInEmailController,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      fieldValidator: (String? value) {
                        if (value!.isEmpty) {
                          return 'This Field is Required and Cannot be Empty';
                        } else if (value.length < 5 ||
                            !value.contains('@') ||
                            !value.contains('.')) {
                          return 'Please Enter Valid Mail';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
// Password
                    CustomTextFormField(
                      fieldController:
                          signInController.signInPasswordController,
                      hintText: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      fieldValidator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please Enter Password";
                        } else if (value.length < 8) {
                          return "Password must be at least 8 characters long";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        const Text('Don\'t Have Account?'),
                        const SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: SignUpScreen(),
                                    type: PageTransitionType
                                        .rightToLeftWithFade));
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent[700],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    signInController.isLoadingSignIn
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (signInController.signInFormKey.currentState!
                                  .validate()) {
                                print(
                                    "Hello ${signInController.signInEmailController.text}");
                                signInController
                                    .signInWithEmailAndPassword(
                                        context: context,
                                        email: signInController
                                            .signInEmailController.text,
                                        password: signInController
                                            .signInPasswordController.text)
                                    .then((value) {
                                  if (value == true) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        PageTransition(
                                            child: HomeScreen(),
                                            type: PageTransitionType
                                                .rightToLeftWithFade),
                                        (route) => false);
                                  }
                                });
                              }
                            },
                            child: Text('Sign In'),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
