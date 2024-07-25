import 'package:flutter/material.dart';

import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';


class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: AppColors.white),
      controller: controller,
      decoration: AppStyle.inputDecoration(hintText: 'email'),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}
