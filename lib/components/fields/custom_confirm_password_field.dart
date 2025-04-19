import 'package:flutter/material.dart';

import '../../constants/themes/custom_theme.dart';

class CustomConfirmPasswordField extends StatelessWidget {
  CustomConfirmPasswordField({
    super.key,
    required this.name,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.confirmErrorMessage,
    required this.dosnotMatchErrorMessage,
  });
  final String name;
  final String confirmErrorMessage;
  final String dosnotMatchErrorMessage;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: confirmPasswordController,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        labelText: name,
        labelStyle: TextStyle(color: Colors.grey),
        floatingLabelStyle: TextStyle(color: AppColors.primary),
        focusColor: AppColors.primary,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.9, color: AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.9,
            color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.9, color: Color(0xffA02C2B)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.9, color: Color(0xffA02C2B)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return confirmErrorMessage;
        }
        if (value != passwordController.text) {
          return dosnotMatchErrorMessage;
        }
        return null;
      },
    );
  }
}
