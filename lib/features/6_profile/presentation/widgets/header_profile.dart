


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:runner_app/features/2_auth/data/models/UserDataDataModel.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../2_auth/presentation/manager/auth/auth_bloc.dart';
import '../../../3_home/data/models/user_data_model.dart';

class HeaderProfile extends StatefulWidget {
  const HeaderProfile({super.key, required this.userData});
  final UserDataDataModel userData;

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
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                widget.  userData.name??'' ,
                  style: AppStyle.textStyle16GWhiteW800,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.  userData.rank??'' ,
                      style: AppStyle.textStyle12GrayW400,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      widget.  userData.currentLevel.toString()??'' ,
                      style: AppStyle.textStyle12GrayW400,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            widget.  userData.roles??'' ,
            style: AppStyle.textStyle20GoldW800,
          ),
        ],
      ),
    );
  }
}
