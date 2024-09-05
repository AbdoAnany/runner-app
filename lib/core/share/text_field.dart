import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../../core/utils/Validators.dart';


class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  const MyTextField({super.key, required this.controller, this.keyboardType=TextInputType.text, });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only( top : 12.h),
      child: TextFormField(
        style: const TextStyle(color: AppColors.white),
        controller: controller,

        decoration: AppStyle.inputDecoration(hintText: 'enter '),
        keyboardType: keyboardType,
        validator: (value)=>Validators.validateEmail(value!),
      ),
    );
  }
}
