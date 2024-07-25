import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/style/color.dart';
import '../../domain/entities/product.dart';

class PopularProductItem extends StatelessWidget {
  final Product product;

  const PopularProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 174.h,
      width: 163.w,
      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.0.h),
      margin:  EdgeInsets.only(left: 12.0.w, top: 0.0.h),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        border: Border.all(color: AppColors.border1ContainerColor),

        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Stack(
              children: [
                Center(child: Image.asset(product.image, fit: BoxFit.fill)),
                Positioned(
                  top: 4.h,
                  right: 4.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Iconsax.coin_1, color: Colors.white, size: 12.w),
                        SizedBox(width: 4,),
                        Text(
                          '${product.price.toStringAsFixed(0)}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.brand,
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  product.model,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
