import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../data/models/user_data_model.dart';
import '../bloc/home_bloc.dart';

class TotalPointAndSteps extends StatelessWidget {
  const TotalPointAndSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<HomeBloc,HomeState>(
          builder: (context,s) {
            if(s is HomeLoaded) {
              return _build(s.userDataDataModel);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }


      );



  }

  _build (UserDataDataModel userDataDataModel) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 12.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //   SizedBox(width: 17.w,),
        Container(
          height: 125.h,
          width: 154.w,
          decoration: AppStyle.decorationHome,
          child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              userDataDataModel.currentXP.toString(),
              style: AppStyle.textStyle48WhiteW400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Iconsax.activity
              ,color: AppColors.white,
              ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'activity points',
                  style: AppStyle.textStyle12GrayLightW400,
                ),
              ],
            )
          ]),
        ),

        Container(
          height: 125.h,
          width: 154.w,
          decoration:  AppStyle.decorationHome,
          child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              userDataDataModel.activeNumber.toString(),
              style: AppStyle.textStyle48WhiteW400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.coin_1,
                  color: AppColors.white,
                  size: 20.w,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Earned Points',
                  style: AppStyle.textStyle12GrayLightW400,
                ),
              ],
            )
          ]),
        ),
        //    SizedBox(width: 17.w,),
      ],
    ),
  );
}
