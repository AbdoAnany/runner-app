
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';

class OfferList extends StatelessWidget {
  const OfferList({super.key});

  @override
  Widget build(BuildContext context) {
    return    SizedBox(width: double.infinity,
        child:

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.0.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [1,2].map((data)=>  Container(
                margin: EdgeInsets.symmetric(horizontal: 6.0,vertical: 8),

                height: 125,width: 291,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: AppColors.storeCard[data],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Today’s Special',style: AppStyle.textStyle18WhiteW700,),
                            SizedBox(height: 4.h,),
                            Text('Get 2x point for every steps, only valid for today',style: AppStyle.textStyle12WhiteW400,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: Image.asset(AppImage.card1Card,fit: BoxFit.cover,))
                  ],
                ),
              ),).toList(),
            ),
          ),
        ));
  }
}
