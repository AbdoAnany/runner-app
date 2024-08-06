


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/style/app_style.dart';

import '../pages/language_toggle.dart';
import '../pages/profile_screen.dart';
import 'ProfileListItem.dart';

class ProfileBodyList extends StatelessWidget {
  const ProfileBodyList({super.key, required this.profileItems});
  final List<ProfileListItemModel> profileItems ;
  @override
  Widget build(BuildContext context) {
    return      Container(
      margin: EdgeInsets.symmetric(vertical:8.w, horizontal: 16.w),
      decoration: AppStyle.decorationHome,
      child: Column(
        children: profileItems.map((item) {
          return ProfileListItem(
            itemModel :item,
            trailing: item.text == 'Language' ? LanguageToggle() : null,
          );
        }).toList(),
      ),
    );
  }
}
