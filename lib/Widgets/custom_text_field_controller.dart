import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController fieldController;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?) fieldValidator;
  const CustomTextFormField({
    super.key,
    required this.fieldController,
    required this.keyboardType,
    required this.hintText,
    required this.fieldValidator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      validator: fieldValidator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
