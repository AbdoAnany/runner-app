import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_style.dart';
import '../../domain/entities/product.dart';
import 'popular_product_item.dart';

class PopularProductList extends StatelessWidget {
  final List<Product> products;
  final VoidCallback onLoadMore;

  const PopularProductList({
    Key? key,
    required this.products,
    required this.onLoadMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular',
                style:AppStyle.textStyle18WhiteW700,
              ),
              InkWell(
                onTap: (){

                },
                child: Text(
                  'See All',
                  style:AppStyle.textStyle14PrimaryW400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 174.h,width: double.infinity,
          child: ListView.builder(

            scrollDirection: Axis.horizontal,

            // physics: NeverScrollableScrollPhysics(),
            itemCount: products.length ,
            itemBuilder: (context, index) {
              // if (index == products.length) {
              //   return  Center(child: Text("No Item Found",style: AppStyle.textStyle14WhiteW400,));
              // }
              return PopularProductItem(product: products[index]);
            },
          ),
        ),
      ],
    );
  }
}

// List productList =[
//   const PopularItem(
//     image: AppImage.nike1,
//     brand: 'Nike',
//     model: 'Air Force 1 Low \'07',
//     price: '1200',
//     isPopular: false,
//   ),  const PopularItem(
//     image: AppImage.nike1,
//     brand: 'Nike',
//     model: 'Air Lunaroll 1',
//     price: '1400',
//     isPopular: false,
//   ),  const PopularItem(
//     image: AppImage.nike1,
//     brand: 'Nike',
//     model: 'Air Force 2 Low \'07',
//     price: '700',isPopular: true,
//   ),  const PopularItem(
//     image: AppImage.nike1,
//     brand: 'Nike',
//     model: 'Air Force 7 Low \'07',
//     price: '4200',isPopular: true,
//   ),  const PopularItem(
//     image: AppImage.nike1,
//     brand: 'Nike',
//     model: 'Air Force 10 Low \'07',
//     price: '12000',isPopular: true,
//   ),
// ];
