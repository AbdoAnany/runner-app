import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_style.dart';
import '../../domain/entities/category.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;

  const CategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 12.0.w),

      height: 85.h,width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
            children: [
              Container(
            width: 65.w,
             height: 70.h,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(category.image!),
                    fit: BoxFit.cover,
                  ),
                ),child:    Align(alignment: Alignment.bottomCenter,

                  child: Text(category.name,style: AppStyle.textStyle12GrayW400,)),
              ),


            ],
          );
        },
      ),
    );
  }
}