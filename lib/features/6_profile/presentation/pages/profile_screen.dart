import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:runner_app/core/const/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../2_auth/presentation/manager/auth/auth_bloc.dart';
import 'dart:async';



final List<ProfileListItemModel> profileItems = [
  ProfileListItemModel(icon: Iconsax.user, text: 'Personal Information'),
  ProfileListItemModel(icon: Iconsax.wallet, text: 'My Wallet'),
  ProfileListItemModel(icon: Iconsax.notification, text: 'Notifications'),
  ProfileListItemModel(icon: Iconsax.language_circle, text: 'Language'),
  ProfileListItemModel(icon: Iconsax.support, text: 'Support'),
  ProfileListItemModel(icon: Iconsax.like_dislike, text: 'Rate App'),
  ProfileListItemModel(icon: Iconsax.message_question, text: 'FAQs'),
  ProfileListItemModel(icon: Iconsax.share, text: 'Share App'),
  ProfileListItemModel(icon: Iconsax.logout_1, text: 'Log Out'),
];




class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _formattedDate = '';
  String _formattedTime = '';
  @override
  void initState() {

    DateTime now = DateTime.now();

    _formattedDate = DateFormat('dd MMM ').format(now);
    _formattedTime = DateFormat('HH : mm').format(now);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return    Column(
      children: [
        Container(
          margin: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 16.w),
          decoration: AppStyle.decorationHome,
          //      color: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [


              Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary.withOpacity(.3), width: 3),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image:  AssetImage(AppImage.person),
                      ))),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
SizedBox(height: 20,),
                    Text(
                      AuthBloc.currentUser!.email,

                      style: AppStyle.textStyle16GWhiteW800,
                    ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            _formattedDate,
                            style: AppStyle.textStyle12GrayW400,
                          ),SizedBox(width: 8.w,),

                          Text(
                            _formattedTime,
                            style: AppStyle.textStyle12GrayW400,
                          ),
                        ],
                      ),




                  ],
                ),
              ),

              Text(
                AuthBloc.currentUser!.role.toUpperCase(),
                style: AppStyle.textStyle20GoldW800,
              ),

            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16.w),
          decoration: AppStyle.decorationHome,
          child: Column(
            children: profileItems.sublist(0, 4).map((item) {
              return ProfileListItem(
                icon: item.icon,
                text: item.text,
                trailing: item.text == 'Language' ? LanguageToggle() : null,
              );
            }).toList(),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
          decoration: AppStyle.decorationHome,
          child: Column(
            children: profileItems.sublist(4).map((item) {
              return ProfileListItem(
                icon: item.icon,
                text: item.text,
              );
            }).toList(),
          ),
        ),
      ],
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
          Icon(icon,color: AppColors.iconHomeColor,),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),

            child: Text(text, style:AppStyle.textStyle18WhiteW700),
          ),
          Spacer(),
          trailing??  Icon(Icons.arrow_forward_ios, size: 16.w, color: AppColors.iconHomeColor,),



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
class ProfileListItemModel {
  final IconData icon;
  final String text;

  ProfileListItemModel({required this.icon, required this.text});
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