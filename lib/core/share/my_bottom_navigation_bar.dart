

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../style/color.dart';

class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar({super.key, this.currentIndex = 0, required this.onTap});

  final int currentIndex;

  void Function( int ) onTap;
  @override
  Widget build(BuildContext context) {
    print(currentIndex);
    return   Positioned(
      bottom: 0,left: 0,right: 0,            child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color:    AppColors.bgFiledColor,
        // gradient:  RadialGradient(colors: [
        //   AppColors.bgFiledColor,
        //   AppColors.primary.withOpacity(.24),
        // ]),
        border: Border.all(color: AppColors.white.withOpacity(.17)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowContainerColor.withOpacity(.05),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.primary.withOpacity(.24),
            spreadRadius: 0,
            blurRadius: 24,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 40),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GradientIcon(
            icon: Iconsax.home_25,
            isSelected: currentIndex == 0,
            onTap: ()=>onTap(0),
          ),
          GradientIcon(
            icon: Iconsax.cup5,
            isSelected: currentIndex == 1,
            onTap: ()=>onTap(1),
          ),
          GradientIcon(
            icon: Iconsax.shopping_bag5,
            isSelected: currentIndex == 2,
            onTap: ()=>onTap(2),
          ),
          GradientIcon(
            icon: Icons.person_rounded,
            isSelected: currentIndex == 3,
            onTap: ()=>onTap(3),
          ),
        ],
      ),
    ),);
  }
}
class GradientIcon extends StatelessWidget {
  const GradientIcon({
    Key? key,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: isSelected
                ? [AppColors.primary, AppColors.dotColor]
                : [AppColors.iconHomeColor, AppColors.iconHomeColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        child: Icon(
          icon,
          color: AppColors.iconHomeColor,
          size: 32.w,
        ),
      ),
    );
  }
}
