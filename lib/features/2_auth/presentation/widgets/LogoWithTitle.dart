import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/constants/app_images.dart';
import 'package:runner_app/core/style/color.dart';

import '../../../../core/style/app_style.dart';

class LogoWithTitle extends StatelessWidget {
  final String title, subText;
  final List<Widget> children;

  const LogoWithTitle(
      {Key? key,
      required this.title,
      this.subText = '',
      required this.children})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.1),
                Padding(
                  padding: EdgeInsets.only(top: 0.h, bottom: 12.h),
                  child: Image.asset(
                    AppImage.logoImage,
                    height: 100.h,
                    width: 100.w,
                  ),
                ),
                Text(
                  title,
                  style: AppStyle.fWhiteS21W700,
                ),

                // SizedBox(
                //   height: constraints.maxHeight * 0.05,
                //   width: double.infinity,
                // ),
                // Text(
                //   title,
                //   style: Theme.of(context)
                //       .textTheme
                //       .headlineSmall!
                //       .copyWith(fontWeight: FontWeight.bold),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    subText,
                    textAlign: TextAlign.center,
                    style: AppStyle.fWhiteS18W700,

                  ),
                ),
                ...children,
              ],
            ),
          );
        }),
      ),
    );
  }
}