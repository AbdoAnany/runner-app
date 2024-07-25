import 'package:flutter/material.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';


class RoleDropdown extends StatelessWidget {
  final List<String> roles;
  final String selectedRole;
  final ValueChanged<String?> onChanged;

  RoleDropdown({required this.roles, required this.selectedRole, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
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
    );
  }
}
