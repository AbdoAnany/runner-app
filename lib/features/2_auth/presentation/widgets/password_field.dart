import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';


class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  String? Function(String?) validator;
  PasswordField({required this.controller, this.hintText = 'password',required this.validator});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  void changeObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only( top : 12.h),
      child: TextFormField(
        controller: widget.controller,
        style: TextStyle(color: AppColors.white),
        validator: widget.validator,
        decoration:

        AppStyle.inputDecoration(hintText:  widget.hintText,changeObscureText: changeObscureText,obscureText: obscureText),

        obscureText: obscureText,
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Please enter a password';
        //   }
        //   if (value.length < 6) {
        //     return 'Password must be at least 6 characters long';
        //   }
        //   return null;
        // },
      ),
    );
  }
}
