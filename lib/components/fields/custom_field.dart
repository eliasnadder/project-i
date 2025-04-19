import 'package:flutter/material.dart';

import '../../constants/themes/custom_theme.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.name,
    required this.filled,
    required this.errorMessage,
    required this.controller,
    this.onChanged,
  });

  final String name;
  final String errorMessage;
  final bool filled;
  final TextEditingController controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      
      cursorColor: AppColors.primary,
      onChanged: onChanged,
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
        if (filled) {
          if (value == null || value.isEmpty) {
            return errorMessage;
          }
          return null;
        }
        return null;
      },
    );
  }
}
