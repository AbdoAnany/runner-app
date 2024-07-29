import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:runner_app/core/const/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../2_auth/presentation/manager/auth/auth_bloc.dart';
import '../../../2_auth/presentation/manager/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:async';
import 'package:flutter/material.dart';








class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          Container(
            //      color: AppColors.primary,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(AppImage.person), // Replace with your asset image
                ),
                SizedBox(height: 12.w),
                Column(
                  children: [
                    Text(
                      'عبدالله عزالدين',
                      style: AppStyle.textStyle16GWhiteW800,
                    ),   Text(
                      '+20 10 153 2346',
                      style: AppStyle.textStyle16GWhiteW800,
                    ),
                  ],
                ),


              ],
            ),
          ),
          CustomTextFormField(
            hintText: 'Enter some text',
            cacheKey: 'unique_key_for_this_field',
          ),
          // Text(
          //     'Profile Information',
          //     style: AppStyle.textStyle16GWhiteW800),
          // SizedBox(height: 20.h),
          //
          // Text(
          //     'Name: ${FirebaseAuth.instance.currentUser?.email?.split('@').first}',
          //     style: AppStyle.textStyle12WhiteW400),
          // Text(
          //     'Role: ${AuthBloc.currentUser?.role}',
          //     style: AppStyle.textStyle12WhiteW400),
          // Text(
          //     'Email:  ${FirebaseAuth.instance.currentUser?.email}',
          //     style: AppStyle.textStyle12WhiteW400),
          // Text(
          //     'lastSignInTime: ${FirebaseAuth.instance.currentUser?.metadata.lastSignInTime}',
          //     style: AppStyle.textStyle12WhiteW400),
          //
          //
          // SizedBox(height: 20.h),
          // MaterialButton(
          //   color: AppColors.primary,
          //   onPressed: () =>BlocProvider.of<AuthBloc>(context).add(SignOutRequested(),)
          //   ,
          //   child: Text('LogOut' ,style: AppStyle.textStyle14WhiteW400,),
          // ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0.h, horizontal: 16.w),
                  decoration: AppStyle.decorationHome,
                  child:
                  Column(
                    children: [
                      ProfileListItem(
                        icon: Iconsax.user,
                        text: 'البيانات الشخصية',
                      ),
                      ProfileListItem(
                        icon: Iconsax.wallet,
                        text: 'محفظتي',
                      ),
                      ProfileListItem(
                        icon: Iconsax.notification,
                        text: 'الإشعارات',
                      ),
                      ProfileListItem(
                        icon: Iconsax.language_circle,
                        text: 'اللغة',
                        trailing: LanguageToggle(),
                      ),
                    ],
                  ),),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                  decoration: AppStyle.decorationHome,
                  child: Column(
                    children: [
                      ProfileListItem(
                        icon: Iconsax.support,
                        text: 'الدعم',
                      ),
                      ProfileListItem(
                        icon: Iconsax.like_dislike,
                        text: 'تقييم التطبيق',
                      ),
                      ProfileListItem(
                        icon: Iconsax.message_question,
                        text: 'الأسئلة المتكررة',
                      ),
                      ProfileListItem(
                        icon: Iconsax.share,
                        text: 'مشاركة التطبيق',
                      ),
                      ProfileListItem(
                        icon: Iconsax.logout_1,
                        text: 'تسجيل الخروج',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('V1.2.0  |  سياسة الخصوصية  |  الشروط والأحكام'),
          ),
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget? trailing;

  ProfileListItem({
    required this.icon,
    required this.text,
    this.trailing ,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
      child: Row(
        children: [
          trailing??  Icon(Icons.arrow_back_ios, size: 16.w, color: AppColors.iconHomeColor,),
          Spacer(),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),

            child: Text(text, style:AppStyle.textStyle18WhiteW700),
          ),

          Icon(icon,color: AppColors.iconHomeColor,),
        ],

      ),
    );
  }
}

class LanguageToggle extends StatefulWidget {
  @override
  _LanguageToggleState createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  bool isArabic = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isArabic = true;
            });
          },
          child: Text(
            'AR',
            style: TextStyle(
              color: isArabic ? Colors.white : Colors.grey,
              fontWeight:isArabic ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Switch(
          activeColor: AppColors.primary,
          value: isArabic,

          onChanged: (value) {
            setState(() {
              isArabic = value;
            });
          },
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isArabic = false;
            });
          },
          child: Text(
            'EN',
            style: TextStyle(
              fontWeight:isArabic ? FontWeight.normal : FontWeight.bold,
              color: isArabic ? Colors.grey : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}


class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String cacheKey;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.cacheKey,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController _controller;
  Timer? _debounce;
  bool _isTyping = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadSavedText();
  }

  void _loadSavedText() async {
    final prefs = await SharedPreferences.getInstance();
    final savedText = prefs.getString(widget.cacheKey) ?? '';
    setState(() {
      _controller.text = savedText;
      _isSaved = savedText.isNotEmpty;
    });
  }

  void _onChanged(String value) {
    setState(() {
      _isTyping = value.isNotEmpty;
      _isSaved = false;
    });

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 5), () {
      _saveToCache(value);
    });
  }

  void _saveToCache(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(widget.cacheKey, value);
    setState(() {
      _isSaved = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: _buildSuffixIcon(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: _onChanged,
    );
  }

  Widget _buildSuffixIcon() {
    if (_controller.text.isEmpty) {
      return const Icon(Icons.question_mark, color: Colors.grey);
    } else if (_isTyping && !_isSaved) {
      return const Icon(Icons.timer, color: Colors.blue);
    } else {
      return const Icon(Icons.check, color: Colors.green);
    }
  }
}