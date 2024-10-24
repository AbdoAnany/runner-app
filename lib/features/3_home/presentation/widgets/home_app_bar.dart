import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      leading: const Icon(
        Iconsax.menu_1,
        color: AppColors.iconHomeColor,
      ),
      title: Row(
        children: [
          Image.asset(
            AppImage.logoImage,
            width: 40.w,
          ),
          SizedBox(
            width: 12.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HELLO!',
                style: AppStyle.textStyle12WhiteW400,
              ),
              Text(
                'Daniela',
                style: AppStyle.textStyle16GWhiteW800,
              ),
            ],
          ),
        ],
      ),
      actions: [
        const Badge(
          smallSize: 8,
          backgroundColor: AppColors.dotColor,
          child: Icon(
            Iconsax.direct_normal,
            color: AppColors.iconHomeColor,
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        const Badge(
          smallSize: 8,
          backgroundColor: AppColors.dotColor,
          child: Icon(
            Iconsax.sms_notification,
            color: AppColors.iconHomeColor,
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 60.h);
}
