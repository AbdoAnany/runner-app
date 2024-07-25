import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../domain/entities/brand.dart';

class BrandList extends StatelessWidget {
  final List<Brand> brands;

  const BrandList({Key? key, required this.brands}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
      height: 164.h,
      width: double.infinity,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            mainAxisExtent: 65.h),
        children: brands
            .map((item) => Container(
                  height: 73.h,
                  width: 73.w,
                  decoration: BoxDecoration(
                    color: AppColors.storeContainerBrand,
                    border: Border.all(color: AppColors.white.withOpacity(.09)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      item.image.toString().isNotEmpty
                          ? Image.asset(
                        item.image,
                              width: 32.w,
                              height: 32.h,
                            )
                          : SizedBox(
                              height: 32.h,
                            ),
                      Text(
                        item.name,
                        style: AppStyle.textStyle12GrayW400,
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
