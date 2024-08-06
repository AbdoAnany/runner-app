import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../pages/profile_screen.dart';

class ProfileListItem extends StatelessWidget {
  final Widget? trailing;
  final ProfileListItemModel? itemModel;

  const ProfileListItem({
    super.key,
    required this.itemModel,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: itemModel?.onTap,
      child: Container(
        height: 45.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        child: Row(
          children: [
            Icon(
              itemModel?.icon,
              color: AppColors.iconHomeColor,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
              child: Text(itemModel!.text, style: AppStyle.textStyle18WhiteW700),
            ),
            const Spacer(),
            trailing ?? Icon(
                  Icons.arrow_forward_ios,
                  size: 16.w,
                  color: AppColors.iconHomeColor,),
          ],
        ),
      ),
    );
  }
}
