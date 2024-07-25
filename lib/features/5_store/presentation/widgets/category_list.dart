import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/style/app_style.dart';
import '../../domain/entities/category.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;

  const CategoryList({Key? key, required this.categories}) : super(key: key);
  // SizedBox(height: 80.h,width: double.infinity,
  // child:
  //
  // SingleChildScrollView(
  // scrollDirection: Axis.horizontal,
  // child: Row(
  // children: runnerData.map((data)=>Column(
  // children: [
  // Image.asset(data['image'],width: 65.w,
  // height: 70,
  // ),
  // Text(data['name'],style: AppStyle.textStyle12GrayW400,),
  // ],
  // )).toList(),
  // ),
  // )),
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 80.h,width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(category.image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Text(category.name,style: AppStyle.textStyle12GrayW400,),
              ],
            ),
          );
        },
      ),
    );
  }
}