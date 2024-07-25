import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:runner_app/features/3_home/presentation/widgets/home_app_bar.dart';

import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';

class ShareAppBar extends StatelessWidget implements PreferredSizeWidget {
  ShareAppBar({super.key, this.currentIndex = 0, this.title = '', this.onTap});

  final int currentIndex;
  final String title;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return currentIndex != 0
        ? AppBar(
            backgroundColor: AppColors.transparent,
            elevation: 0,
            leading: InkWell(
                onTap: onTap,
                child: const Icon(Iconsax.arrow_square_left,
                    color: AppColors.iconHomeColor)),
            title: Text(
              title,
              style: AppStyle.textStyle16GWhiteW800,
            ),
            actions: [
              const Badge(
                smallSize: 10,
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
                smallSize: 10,
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
          )
        : const HomeAppBar();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 60.h);
}
