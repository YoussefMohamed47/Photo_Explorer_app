import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photos_project/Modules/Auth/Sign%20In/sign_in_screen.dart';
import 'package:photos_project/Modules/Auth/Sign%20Up/sign_up_controller.dart';
import 'package:photos_project/Widgets/custom_text_field_controller.dart';
import 'package:provider/provider.dart';

import '../../Home/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Consumer<SignUpController>(
            builder: (_, signUpController, child) => Form(
              key: signUpController.signUpFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // First Name
                  CustomTextFormField(
                    fieldController: signUpController.firstNameController,
                    hintText: 'First Name',
                    keyboardType: TextInputType.text,
                    fieldValidator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter First Name";
                      } else {
                        return null;
                      }
                    },
                  ),

                  // last Name
                  CustomTextFormField(
                    fieldController: signUpController.lastNameController,
                    hintText: 'Last Name',
                    keyboardType: TextInputType.text,
                    fieldValidator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter Last Name";
                      } else {
                        return null;
                      }
                    },
                  ),

                  IntlPhoneField(
                    keyboardType: TextInputType.phone,
                    controller: signUpController.phoneController,
                    validator: (PhoneNumber? value) {
                      print('in widget validator ${value}');
                      if (value == null || value.number.isEmpty) {
                        print('Please Enter Your Phone No');
                        return 'Please Enter Your Phone No';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.always,
                    countries: const [
                      Country(
                        name: "United States",
                        nameTranslations: {
                          "sk": "Spojené štáty",
                          "se": "Amerihká ovttastuvvan stáhtat",
                          "pl": "Stany Zjednoczone",
                          "no": "USA",
                          "ja": "アメリカ合衆国",
                          "it": "Stati Uniti",
                          "zh": "美国",
                          "nl": "Verenigde Staten",
                          "de": "Vereinigte Staaten",
                          "fr": "États-Unis",
                          "es": "Estados Unidos",
                          "en": "United States",
                          "pt_BR": "Estados Unidos",
                          "sr-Cyrl": "Сједињене Америчке Државе",
                          "sr-Latn": "Sjedinjene Američke Države",
                          "zh_TW": "美國",
                          "tr": "Amerika Birleşik Devletleri",
                          "ro": "Statele Unite ale Americii",
                          "ar": "الولايات المتحدة",
                          "fa": "ایالات متحده آمریکا",
                          "yue": "美利堅郃眾囯"
                        },
                        flag: "🇺🇸",
                        code: "US",
                        dialCode: "1",
                        minLength: 10,
                        maxLength: 10,
                      ),
                    ],
                    disableLengthCheck: false,
                    decoration: const InputDecoration(
                      counter: Offstage(),
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'US',
                    showDropdownIcon: false,
                    // dropdownIconPosition: IconPosition.trailing,
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),

                  // Email
                  CustomTextFormField(
                    fieldController: signUpController.signUpEmailController,
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

// Password
                  CustomTextFormField(
                    fieldController: signUpController.signUpPasswordController,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    obSecuredText: signUpController.passwordVisible,
                    suffixIcon: InkWell(
                      onTap: () {
                        signUpController.changePasswordVisibility();
                      },
                      child: Icon(
                        signUpController.passwordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
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

                  // Confirm Password
                  CustomTextFormField(
                    fieldController:
                        signUpController.signUpConfirmPasswordController,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    obSecuredText: signUpController.confirmPasswordVisible,
                    suffixIcon: InkWell(
                      onTap: () {
                        signUpController.changeConfirmPasswordVisibility();
                      },
                      child: Icon(
                        signUpController.confirmPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    fieldValidator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Re-Enter Password";
                      } else if (value.length < 8) {
                        return "Password must be at least 8 characters long";
                      } else if (value !=
                          signUpController.signUpPasswordController.text) {
                        return "Password must be same as above";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Row(
                    children: [
                      const Text('Already Have Account?'),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: SignInScreen(),
                                  type:
                                      PageTransitionType.rightToLeftWithFade));
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            color: Colors.blueAccent[700],
                          ),
                        ),
                      )
                    ],
                  ),
                  signUpController.isLoadingSignUp
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (signUpController.signUpFormKey.currentState!
                                .validate()) {
                              print(
                                  "Hello ${signUpController.signUpEmailController.text}");
                              signUpController
                                  .createUserWithEmailAndPassword(
                                      context: context,
                                      email: signUpController
                                          .signUpEmailController.text,
                                      password: signUpController
                                          .signUpPasswordController.text)
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
                          child: Text('Sign Up'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
