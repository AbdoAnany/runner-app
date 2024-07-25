import 'package:flutter/material.dart';
import '../../../../core/style/color.dart';


class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  PasswordField({required this.controller, this.hintText = 'password'});

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
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppColors.textGray),
        fillColor: AppColors.bgFiledColor,
        suffix: InkWell(
          child: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppColors.white,
          ),
          onTap: changeObscureText,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary.withOpacity(.8)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }
}
