import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../../core/utils/Validators.dart';


class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller, });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only( top : 12.h),
      child: TextFormField(
        style: TextStyle(color: AppColors.white),
        controller: controller,
        decoration: AppStyle.inputDecoration(hintText: 'email'),
        keyboardType: TextInputType.emailAddress,
        validator: (value)=>Validators.validateEmail(value!),
      ),
    );
  }
}
