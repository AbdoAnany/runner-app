import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:runner_app/core/style/app_style.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:runner_app/features/ui/screens/runner_data_screen.dart';

import '../../../../core/const/const.dart';
import '../../../../core/share/main_Screen.dart';
import '../../../blocs/runner_data/runner_data_bloc.dart';
import '../../../blocs/runner_data/runner_data_state.dart';
import '../../../services/role_service.dart';
import '../widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  // final dynamic user;

  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, dynamic>> _rolePermissions;
  String _formattedDate = '';
  String _formattedTime = '';
  int currentSteps = 14000;
  int goalSteps = 15000;
  double progress = 0;
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    progress = currentSteps / goalSteps;

    _formattedDate = DateFormat('dd MMM').format(now);
    _formattedTime = DateFormat('HH : mm : ss').format(now);

    _rolePermissions = RoleService().getRolePermissions('admin');
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const HomeAppBar(),
        Container(
          height:
          48.0.h, // Use static height if you're not using screen sizes
          margin: EdgeInsets.symmetric(
              horizontal: 6.0, vertical: 6.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${NumberFormat("#,000").format(currentSteps)} /',
                            style: AppStyle.textStyle12GrayW400,
                          ),
                          Text(
                            '${NumberFormat("#,000").format(goalSteps)}',

                            style: AppStyle.textStyle20GWhiteW800,
                          ),
                          Text(
                            ' steps',
                            style: AppStyle.textStyle12GrayW400,
                          ),
                          Spacer(),
                          Text(
                            'Level 5',
                            style: AppStyle.textStyle20GoldW800,
                          ),
                        ],
                      ),


                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          height: 10.0, width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),

                            color: AppColors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadowContainerColor,
                                spreadRadius: 1,
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CustomPaint(
                            painter: GradientProgressPainter(
                              progress: progress,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.bar1HomeColor,
                                  AppColors.bar2HomeColor,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset(
                AppImage.levelBadge,
                width: 48.0.w,
                height: 48.h,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 4.h),
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
                  _formattedDate,
                  style: AppStyle.textStyle12GrayW400,
                ),
                Text(
                  'Today',
                  style: AppStyle.textStyle15GreenW500,
                ),
                Text(
                  _formattedTime,
                  style: AppStyle.textStyle12GrayW400,
                ),
              ],
            ),
            Spacer(),
            Image.asset(AppImage.radius)
          ]),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 12.w, vertical: 12.h),
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
                        mainAxisAlignment:
                        MainAxisAlignment.center,
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
                        mainAxisAlignment:
                        MainAxisAlignment.center,
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
        ),
        SizedBox(
          height: 40.h,
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            height: 125.h,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImage.shareGift),
                fit: BoxFit.fill,
              ),
            ))
      ],
    );



    //   Scaffold(
    //   extendBody: true,
    //   body: Stack(
    //     children: [
    //       Positioned(
    //         top: 0,
    //         left: 0,
    //         right: 0,
    //         child: Container(
    //           height: 360.h,
    //
    //           decoration: const BoxDecoration(
    //             image: DecorationImage(
    //               image: AssetImage(AppImage.homeGrenadianImage),
    //               fit: BoxFit.fill
    //             ),
    //
    //             borderRadius: BorderRadius.only(
    //                 bottomRight: Radius.circular(16),
    //                 bottomLeft: Radius.circular(12)),
    //             //  border: Border.all(color: AppColors.primary),
    //           ),
    //         ),
    //       ),
    //       Container(height: double.infinity,width: double.infinity,
    //
    //         decoration: const BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage(AppImage.bgPink),fit: BoxFit.fill
    //           ),
    //
    //           //  border: Border.all(color: AppColors.primary),
    //         ),
    //       ),
    //       Column(
    //         children: [
    //           AppBar(
    //             backgroundColor: AppColors.transparent,
    //             elevation: 0,
    //             leading: const Icon(
    //               Iconsax.menu_1,
    //               color: AppColors.iconHomeColor,
    //             ),
    //             title: Row(
    //               children: [
    //                 Image.asset(
    //                   AppImage.logoImage,
    //                   width: 40.w,
    //                 ),
    //                 SizedBox(
    //                   width: 12.w,
    //                 ),
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       'HELLO!',
    //                       style: AppStyle.textStyle12WhiteW400,
    //                     ),
    //                     Text(
    //                       'Daniela',
    //                       style: AppStyle.textStyle16GWhiteW800,
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //             actions: [
    //               const Icon(
    //                 Iconsax.direct_normal,
    //                 color: AppColors.iconHomeColor,
    //               ),
    //               SizedBox(
    //                 width: 12.w,
    //               ),
    //               const Icon(
    //                 Iconsax.sms_notification,
    //                 color: AppColors.iconHomeColor,
    //               ),
    //               SizedBox(
    //                 width: 12.w,
    //               ),
    //             ],
    //           ),
    //           Container(
    //             height:
    //             48.0, // Use static height if you're not using screen sizes
    //             margin: EdgeInsets.symmetric(
    //                 horizontal: 6.0, vertical: 6.0),
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                   child: Padding(
    //                     padding: EdgeInsets.symmetric(horizontal: 12.0),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Row(
    //                           children: [
    //                             Text(
    //                               '${NumberFormat("#,000").format(currentSteps)} /',
    //                               style: AppStyle.textStyle12GrayW400,
    //                             ),
    //                             Text(
    //                               '${NumberFormat("#,000").format(goalSteps)}',
    //
    //                               style: AppStyle.textStyle20GWhiteW800,
    //                             ),
    //                             Text(
    //                               ' steps',
    //                               style: AppStyle.textStyle12GrayW400,
    //                             ),
    //                             Spacer(),
    //                             Text(
    //                               'Level 5',
    //                               style: AppStyle.textStyle20GoldW800,
    //                             ),
    //                           ],
    //                         ),
    //
    //
    //                         ClipRRect(
    //                           borderRadius: BorderRadius.circular(50.0),
    //                           child: Container(
    //                             height: 10.0, width: double.infinity,
    //                             decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(50),
    //
    //                               color: AppColors.white,
    //                               boxShadow: const [
    //                                 BoxShadow(
    //                                   color: AppColors.shadowContainerColor,
    //                                   spreadRadius: 1,
    //                                   blurRadius: 12,
    //                                   offset: Offset(0, 4),
    //                                 ),
    //                               ],
    //                             ),
    //                             child: CustomPaint(
    //                               painter: GradientProgressPainter(
    //                                 progress: progress,
    //                                 gradient: const LinearGradient(
    //                                   begin: Alignment.topLeft,
    //                                   end: Alignment.bottomRight,
    //                                   colors: [
    //                                     AppColors.bar1HomeColor,
    //                                     AppColors.bar2HomeColor,
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 Image.asset(
    //                   AppImage.levelBadge,
    //                   width: 48.0.w,
    //                   height: 48.h,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 4.h),
    //             height: 87.h,
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(20),
    //                 color: AppColors.white.withOpacity(.17)),
    //             child: Row(children: [
    //               Padding(
    //                 padding: EdgeInsets.symmetric(
    //                     vertical: 20.0.h, horizontal: 16.w),
    //                 child: CircleAvatar(
    //                     radius: 25.r,
    //                     backgroundColor: AppColors.primary,
    //                     child: Image.asset(AppImage.runnerMan)),
    //               ),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     _formattedDate,
    //                     style: AppStyle.textStyle12GrayW400,
    //                   ),
    //                   Text(
    //                     'Today',
    //                     style: AppStyle.textStyle15GreenW500,
    //                   ),
    //                   Text(
    //                     _formattedTime,
    //                     style: AppStyle.textStyle12GrayW400,
    //                   ),
    //                 ],
    //               ),
    //               Spacer(),
    //               Image.asset(AppImage.radius)
    //             ]),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.symmetric(
    //                 horizontal: 12.w, vertical: 12.h),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Container(
    //                   height: 125.h,
    //                   width: 163.w,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(20),
    //                       color: AppColors.white.withOpacity(.17)),
    //                   child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Text(
    //                           '53,524',
    //                           style: AppStyle.textStyle48WhiteW400,
    //                         ),
    //                         Row(
    //                           mainAxisAlignment:
    //                           MainAxisAlignment.center,
    //                           children: [
    //                             Image.asset(
    //                               AppImage.steps,
    //                               color: AppColors.iconHomeColor,
    //                               width: 20.w,
    //                               height: 20.h,
    //                             ),
    //                             SizedBox(
    //                               width: 5.w,
    //                             ),
    //                             Text(
    //                               'Steps',
    //                               style: AppStyle.textStyle12GrayW400,
    //                             ),
    //                           ],
    //                         )
    //                       ]),
    //                 ),
    //                 Container(
    //                   height: 125.h,
    //                   width: 163.w,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(20),
    //                       color: AppColors.white.withOpacity(.17)),
    //                   child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Text(
    //                           '1000',
    //                           style: AppStyle.textStyle48WhiteW400,
    //                         ),
    //                         Row(
    //                           mainAxisAlignment:
    //                           MainAxisAlignment.center,
    //                           children: [
    //                             Icon(
    //                               Iconsax.coin_1,
    //                               color: AppColors.iconHomeColor,
    //                               size: 20.w,
    //                             ),
    //                             SizedBox(
    //                               width: 5.w,
    //                             ),
    //                             Text(
    //                               'Earned Points',
    //                               style: AppStyle.textStyle12GrayW400,
    //                             ),
    //                           ],
    //                         )
    //                       ]),
    //                 )
    //               ],
    //             ),
    //           ),
    //           SizedBox(
    //             height: 40.h,
    //           ),
    //           Container(
    //               margin: EdgeInsets.symmetric(horizontal: 16.w),
    //               height: 125.h,
    //               width: double.infinity,
    //               decoration: BoxDecoration(
    //                 image: DecorationImage(
    //                   image: AssetImage(AppImage.shareGift),
    //                   fit: BoxFit.fill,
    //                 ),
    //               ))
    //         ],
    //       ),
    //     ],
    //   ),
    //
    //   bottomNavigationBar:
    //   Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(25),
    //       gradient: LinearGradient(colors: [
    //         AppColors.bgFiledColor,
    //         AppColors.bgFiledColor,
    //       ]),
    //         border: Border.all(color: AppColors.white.withOpacity(.17)),
    //         boxShadow: [
    //           BoxShadow(
    //             color: AppColors.shadowContainerColor.withOpacity(.05),
    //             spreadRadius: 0,
    //             blurRadius: 12,
    //             offset: const Offset(0, 4), // changes position of shadow
    //           ),    BoxShadow(
    //             color: AppColors.primary.withOpacity(.24),
    //             spreadRadius: 0,
    //             blurRadius: 24,
    //             offset: const Offset(0, 0), // changes position of shadow
    //           ),
    //         ],
    //     ),
    //     margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 40),
    //     padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 32),
    //     child: Row(
    //       children: [
    //         const GradientIcon(icon:   Iconsax.home_25,isSelected: true,),
    //         Spacer(),
    //         const GradientIcon(icon:   Iconsax.cup5,isSelected: true,),
    //         Spacer(),
    //         const GradientIcon(icon:   Iconsax.shopping_bag,isSelected: true,),
    //         Spacer(),
    //         const GradientIcon(icon:   Iconsax.user,isSelected: true,),
    //
    //       ],
    //     ),
    //   )
    //
    // );
  }
}



class GradientProgressPainter extends CustomPainter {
  final double progress;
  final Gradient gradient;
  final Paint _paint;

  GradientProgressPainter({
    required this.progress,
    required this.gradient,
  }) : _paint = Paint()
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width * progress, size.height);
    _paint.shader = gradient.createShader(rect);
    canvas.drawRect(rect, _paint);
  }

  @override
  bool shouldRepaint(GradientProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}