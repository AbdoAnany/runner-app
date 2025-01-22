


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:runner_app/core/constants/app_images.dart';
import '../../../../core/share/badge_level_type.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../../3_home/data/services/user_data_service.dart';

// class HeaderProfile extends StatefulWidget {
//      HeaderProfile({super.key,  this.userData});
//    UserDataDataModel? userData;
//
//   @override
//   State<HeaderProfile> createState() => _HeaderProfileState();
// }
//
// class _HeaderProfileState extends State<HeaderProfile> {
//
//   @override
//   void initState() {
//     widget.userData ??= UserDataDataModel(userId: '', fcmToken: '');
//     DateTime now = DateTime.now();
//
//
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 8.w),
//       decoration: AppStyle.decorationHome,
//       //      color: AppColors.primary,
//       padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
//       width: double.infinity,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//               width: 60.w,
//               height: 60.h,
//               decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                       color: AppColors.primary.withOpacity(.3), width: 3),
//                   image: const DecorationImage(
//                     fit: BoxFit.fill,
//                     image: AssetImage(AppImage.person),
//                   ))),
//           SizedBox(width: 12.w),
//           SizedBox(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                 widget.userData?.email??'' ,
//                   style: AppStyle.fWhiteS16W800,
//                 ),
//
//
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.  userData?.rank??'' ,
//                       style: AppStyle.textStyle12GrayW400,
//                     ),
//                     SizedBox(
//                       width: 8.w,
//                     ),
//                     Text(
//                       widget.  userData?.currentLevel.toString()??'' ,
//                       style: AppStyle.textStyle12GrayW400,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Spacer(),
//           Text(
//             widget.  userData?.roles.toUpperCase()??'' ,
//             style: AppStyle.textStyle20GoldW800,
//           ),
//         ],
//       ),
//     );
//   }
// }

class HeaderProfile extends StatefulWidget {
  const HeaderProfile({super.key, this.userId});

  final String? userId;

  @override
  _HeaderProfileState createState() => _HeaderProfileState();
}

class _HeaderProfileState extends State<HeaderProfile> {
  late UserDataService _userDataService;
  UserDataDataModel? _userData;

  @override
  void initState() {
    super.initState();
    _userDataService = UserDataService();

    // Listen to user data updates from the stream
    _userDataService.userDataStream.listen((data) {
      setState(() {
        _userData = UserDataDataModel.fromJson(data);
      });
    });

    // Fetch initial user data
   WidgetsBinding.instance.addPostFrameCallback((_) {
     // _fetchUserData();
   });
  }

  void _fetchUserData() async {
    final data = await _userDataService.getUserData(userId: widget.userId);
    setState(() {
      _userData = UserDataDataModel.fromJson(data ?? {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_userData == null) {
      return const CircularProgressIndicator(); // Show loading indicator if data is null
    }

    return
      true?
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.bgContainerColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: AppColors.border1ContainerColor, width: 1),
          ),
          padding: const EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const BadgeLevelFrame(
                image: AppImage.person,
                levelType: BadgeLevelTypeFrame.Advance,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userData!.name.isEmpty
                          ? "NO Name"
                          : "${_userData!.name}",
                      style: AppStyle.fWhiteS16W800,
                    ),
                    Text(
                      _userData!.email.toString(),
                      style: AppStyle.fWhiteS12W400,
                    ),

                    Text(
                      "Rank  ${_userData!.rank}",
                      style: AppStyle.fWhiteS24W800BebasNeue
                          .copyWith(letterSpacing: 1.2),
                    ),

                    Text(
                      _userData!.userId
                          .toString()
                          .toUpperCase(),
                      style: AppStyle.textStyle8GrayW400,
                    ),
                    //       Text(_userData!.fcmToken.toString().toUpperCase(),style: AppStyle.textStyle10GrayW400,),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _userData!.roles.toString().toUpperCase(),
                    style: AppStyle.textStyle16GoldW800,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    // margin: EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: AppColors.bgColor,
                      border: Border.all(
                          width: 2,
                          color: AppColors.border1ContainerColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _userData!.currentLevel.toString(),
                          style: AppStyle.fWhiteS24W800BebasNeue
                              .copyWith(height: 1),
                        ),
                        Text(
                          "Level",
                          style: AppStyle.fWhiteS21W400BebasNeue
                              .copyWith(height: 1),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )):

      Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: AppStyle.decorationHome,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 3),
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImage.person),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _userData?.email ?? '',
                style: AppStyle.fWhiteS16W800,
              ),
              Row(
                children: [
                  Text(
                    _userData?.rank ?? '',
                    style: AppStyle.textStyle12GrayW400,
                  ),
                  SizedBox(width: 8),
                  Text(
                    _userData?.currentLevel.toString() ?? '',
                    style: AppStyle.textStyle12GrayW400,
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Text(
            _userData?.roles.toUpperCase() ?? '',
            style: AppStyle.textStyle20GoldW800,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _userDataService.dispose(); // Dispose stream when widget is disposed
    super.dispose();
  }
}
