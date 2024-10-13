


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../2_auth/presentation/manager/auth/auth_bloc.dart';

class HeaderProfile extends StatefulWidget {
  const HeaderProfile({super.key});

  @override
  State<HeaderProfile> createState() => _HeaderProfileState();
}

class _HeaderProfileState extends State<HeaderProfile> {
  String _formattedDate = '';
  String _formattedTime = '';
  @override
  void initState() {
    DateTime now = DateTime.now();

    _formattedDate = DateFormat('dd MMM ').format(now);
    _formattedTime = DateFormat('HH : mm').format(now);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 8.w),
      decoration: AppStyle.decorationHome,
      //      color: AppColors.primary,
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppColors.primary.withOpacity(.3), width: 3),
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(AppImage.person),
                  ))),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "AuthBloc.currentUser!.email",
                  style: AppStyle.textStyle16GWhiteW800,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _formattedDate,
                      style: AppStyle.textStyle12GrayW400,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      _formattedTime,
                      style: AppStyle.textStyle12GrayW400,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
           " AuthBloc.currentUser!.role.toUpperCase()",
            style: AppStyle.textStyle20GoldW800,
          ),
        ],
      ),
    );
  }
}
