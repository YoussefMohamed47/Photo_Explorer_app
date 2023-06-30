import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController fieldController;
  final String hintText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool? obSecuredText;
  final String? Function(String?) fieldValidator;
  const CustomTextFormField({
    super.key,
    required this.fieldController,
    required this.keyboardType,
    required this.hintText,
    this.suffixIcon,
    this.obSecuredText,
    required this.fieldValidator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      validator: fieldValidator,
      keyboardType: keyboardType,
      obscureText: obSecuredText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
