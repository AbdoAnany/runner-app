import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:runner_app/core/style/app_style.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:runner_app/features/ui/screens/runner_data_screen.dart';

import '../../../core/const/const.dart';
import '../../blocs/runner_data/runner_data_bloc.dart';
import '../../blocs/runner_data/runner_data_state.dart';
import '../../services/role_service.dart';

class HomeScreen extends StatefulWidget {
  final dynamic user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, dynamic>> _rolePermissions;

  @override
  void initState() {
    super.initState();
    _rolePermissions = RoleService().getRolePermissions('admin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 375.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImage.homeGrenadianImage),
                    ),

                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                    //  border: Border.all(color: AppColors.primary),
                  ),
                ),
              ),
              Column(
                children: [
                  AppBar(
                    backgroundColor: AppColors.transparent,
                    elevation: 0,
                    leading: const Icon(
                      Iconsax.menu_1,
                      color: AppColors.iconHomeColor,
                    ),
                    title: Row(
                      children: [
                        Image.asset(
                          AppImage.logoImage,
                          width: 40.w,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HELLO!',
                              style: AppStyle.textStyle12WhiteW400,
                            ),
                            Text(
                              'Daniela',
                              style: AppStyle.textStyle16GWhiteW800,
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      const Icon(
                        Iconsax.direct_normal,
                        color: AppColors.iconHomeColor,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      const Icon(
                        Iconsax.sms_notification,
                        color: AppColors.iconHomeColor,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 48.h,
                        margin:
                            EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '14,000 /',
                                          style: AppStyle.textStyle12GrayW400,
                                        ),
                                        Text(
                                          ' 15,000',
                                          style: AppStyle.textStyle20GWhiteW800,
                                        ),
                                        Text(
                                          '  steps',
                                          style: AppStyle.textStyle12GrayW400,
                                        ),
                                        Spacer(),
                                        Text(
                                          'Level 5',
                                          style: AppStyle.textStyle20GoldW800,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 70.w),
                                      height: 10.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: AppColors.white),
                                      child: Container(
                                          height: 10.h,
                                          width: 204.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    AppColors.bar1HomeColor,
                                                    AppColors.bar2HomeColor,
                                                  ]),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors
                                                      .shadowContainerColor,
                                                  spreadRadius: 1,
                                                  blurRadius: 12,
                                                  offset: Offset(0,
                                                      4), // changes position of shadow
                                                ),
                                              ])),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Image.asset(
                              AppImage.levelBadge,
                              width: 48.w,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        height: 87.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.white.withOpacity(.17)),
                        child: Row(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0.h, horizontal: 16.w),
                            child: CircleAvatar(
                                radius: 25.r,
                                backgroundColor: AppColors.primary,
                                child: Image.asset(AppImage.runnerMan)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '26 May',
                                style: AppStyle.textStyle12GrayW400,
                              ),
                              Text(
                                'Today',
                                style: AppStyle.textStyle15GreenW500,
                              ),
                              Text(
                                '01 : 09 : 44 ',
                                style: AppStyle.textStyle12GrayW400,
                              ),
                            ],
                          ),
                          Spacer(),
                          Image.asset(AppImage.radius)
                        ]),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 125.h,
                              width: 163.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.white.withOpacity(.17)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '53,524',
                                      style: AppStyle.textStyle48WhiteW400,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppImage.steps,
                                          color: AppColors.iconHomeColor,
                                          width: 20.w,
                                          height: 20.h,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          'Steps',
                                          style: AppStyle.textStyle12GrayW400,
                                        ),
                                      ],
                                    )
                                  ]),
                            ),
                            Container(
                              height: 125.h,
                              width: 163.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.white.withOpacity(.17)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '1000',
                                      style: AppStyle.textStyle48WhiteW400,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Iconsax.coin_1,
                                          color: AppColors.iconHomeColor,
                                          size: 20.w,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          'Earned Points',
                                          style: AppStyle.textStyle12GrayW400,
                                        ),
                                      ],
                                    )
                                  ]),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )

              // FutureBuilder<Map<String, dynamic>>(
              //   future: _rolePermissions,
              //   builder: (context, snapshot) {
              //
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(child: CircularProgressIndicator());
              //     } else if (snapshot.hasError) {
              //       return const Center(child: Text('Error loading permissions'));
              //     } else {
              //       final permissions = snapshot.data ?? {};
              //
              //       return RunnerDataScreen(
              //         viewHistory: permissions['canViewHistory'],
              //         viewPopular: permissions['canViewPopular'],
              //       );
              //     }
              //   },
              // ),
            ],
          ),
SizedBox(height: 40.h,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
              height: 125.h,width: double.infinity,
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImage.shareGift),
              fit: BoxFit.fill,

            ),
          ))
        ],
      ),
    );
  }
}
