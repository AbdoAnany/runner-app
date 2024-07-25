import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';


class RoleDropdown extends StatelessWidget {
  final List<String> roles;
  final String selectedRole;
  final ValueChanged<String?> onChanged;

  RoleDropdown({required this.roles, required this.selectedRole, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only( top : 12.h,bottom: 20.h),
      child: DropdownButtonFormField<String>(
        value: selectedRole,
        style: TextStyle(color: AppColors.white),
        decoration: AppStyle.inputDecoration(hintText: 'role'),
        dropdownColor: AppColors.bgContainerColor,
        items: roles.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
