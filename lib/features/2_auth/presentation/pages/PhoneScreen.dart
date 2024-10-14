import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/style/color.dart';

import '../../../../core/const/const.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/widgets/main_buttom.dart';

class PhoneScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  PhoneScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: LogoWithTitle(
        title: 'Phone',
        subText: "Integer quis dictum tellus, a auctorlorem. Cras in biandit leo suspendiss.",
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                decoration:  AppStyle.inputDecoration(hintText: 'phone'),
                keyboardType: TextInputType.phone,
                onSaved: (phone) {
                  // Save it
                },
              ),
            ),
          ),

          MyMaterialButton(
            width: double.infinity,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
              Navigator.of(context).pushNamed('/verification');
            },
            title: 'Next',
          )
          // ElevatedButton(
          //   onPressed: () {
          //
          //   },
          //   style: ElevatedButton.styleFrom(
          //     elevation: 0,
          //     backgroundColor: const Color(0xFF00BF6D),
          //     foregroundColor: Colors.white,
          //     minimumSize: const Size(double.infinity, 48),
          //     shape: const StadiumBorder(),
          //   ),
          //   child: const Text("Next"),
          // ),
        ],
      ),
    );
  }
}

class LogoWithTitle extends StatelessWidget {
  final String title, subText;
  final List<Widget> children;

  const LogoWithTitle(
      {super.key,
      required this.title,
      this.subText = '',
      required this.children});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: constraints.maxHeight * 0.1),
              Padding(
                padding: EdgeInsets.only(top: 0.h, bottom: 12.h),
                child: Image.asset(
                  AppImage.logoImage,
                  height: 100.h,
                  width: 100.w,
                ),
              ),
              Text(
                title,
                style: AppStyle.textStyle21WhiteW700,
              ),

              SizedBox(
                height: constraints.maxHeight * 0.1,
                width: double.infinity,
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 16.0),
              //   child: Text(
              //     subText,
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       height: 1.5,
              //       color: Theme.of(context)
              //           .textTheme
              //           .bodyLarge!
              //           .color!
              //           .withOpacity(0.64),
              //     ),
              //   ),
              // ),
              ...children,
            ],
          ),
        );
      }),
    );
  }
}
