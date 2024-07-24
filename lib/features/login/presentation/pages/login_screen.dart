import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/const/const.dart';
import 'package:runner_app/core/helper/extension.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:runner_app/features/ui/screens/home_screen.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/style/app_style.dart';

import '../manager/auth/auth_bloc.dart';
import '../manager/auth/auth_event.dart';
import '../manager/auth/auth_state.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController(text: 'abdo@a.com');
  final TextEditingController _passwordController = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc  , AuthState>(
          listener: (BuildContext context, AuthState state) {

            if (state is Authenticated) {
              context.pushScreen(HomeScreen(user: state.user,));
            }else if (state is Unauthenticated) {
              toastification.show(
                alignment: Alignment.bottomCenter,
                context: context, // optional if you use ToastificationWrapper
                title: Text('email or password is not correct'),
                type: ToastificationType.error,
                style: ToastificationStyle.fillColored,
                autoCloseDuration: const Duration(seconds: 3),
              );
            }

          },
            builder: (context, state) {

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 12.h,),

                  Image.asset(AppImage.logoImage, height: 100.h, width:100.w ,),
                  SizedBox(height: 32.h,),
                  Text('Login',
                    style: AppStyle.textStyle21WhiteW700,),
                  SizedBox(height: 12.h,),

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: AppColors.white),
                    controller: _emailController,
                    decoration: InputDecoration(
                    filled: true,
                    hintText: 'email',

                    fillColor: AppColors.bgFiledColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),

                      borderRadius: BorderRadius.circular(10),
                    ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary.withOpacity(.8)),

                        borderRadius: BorderRadius.circular(10),
                      )
                  )),
                  SizedBox(height: 12.h,),
                  TextField(
                    controller: _passwordController,
                    style: TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'password',

                      fillColor: AppColors.bgFiledColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primary),

                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primary.withOpacity(.8)),

                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Row(
                       children: [
                         Checkbox(value: true,
                             activeColor:AppColors.primary,
                             onChanged: (r){}),

                         Text('Remember me',style: AppStyle.textStyle14WhiteW400,)
                       ],
                     ),
                      Spacer(),
                      TextButton(onPressed: (){

                      }, child:   Text('Forgot Password ?',
                        textAlign: TextAlign.center,
                        style: AppStyle.textStyle14PrimaryW400,),)
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: MaterialButton(
                        minWidth: 326.w,elevation: 0,
                        color: AppColors.primary,
                        height: 56.h,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

                        child: Text("Login",style:AppStyle.textStyle18WhiteW700,),
                      onPressed: () {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        BlocProvider.of<AuthBloc>(context).add(
                          SignInRequested(email, password,),
                        );
                      },),
                  ),
                  SizedBox(height: 20.h),
                  Row(children: [
                    Expanded(child: Divider(color: AppColors.textGray2,thickness: .5,)),
                    SizedBox(width: 30.w,),
                    Text('Or continue with',style: AppStyle.textStyle14GrayerW400,),
                    SizedBox(width: 30.w,),
                    Expanded(child: Divider(color: AppColors.textGray2,thickness: .5,)),
                  ],),
                  SizedBox(height: 12.h),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Container(
                      height: 70.h,
                      width: 98.w,
                      padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.bgContainerColor,
                        border: Border.all(color: AppColors.border1ContainerColor),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowContainerColor,
                            spreadRadius: 1,
                            blurRadius: 12,
                            offset: const Offset(0, 4), // changes position of shadow
                          ),
                        ],

                        borderRadius: BorderRadius.circular(12),
                      ),child: Image.asset(AppImage.googleImage,height: 32.h,width: 32.w,),),     Container(
                        height: 70.h,
                        width: 98.w, padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.bgContainerColor,
                          border: Border.all(color: AppColors.border1ContainerColor),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowContainerColor,
                              spreadRadius: 1,
                              blurRadius: 12,
                              offset: const Offset(0, 4), // changes position of shadow
                            ),
                          ],

                          borderRadius: BorderRadius.circular(12),
                        ),child: Image.asset(AppImage.facebookImage),),
                    Container(
                      height: 70.h,
                      width: 98.w, padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.bgContainerColor,
                        border: Border.all(color: AppColors.border1ContainerColor),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowContainerColor,
                            spreadRadius: 1,
                            blurRadius: 12,
                            offset: const Offset(0, 4), // changes position of shadow
                          ),
                        ],

                        borderRadius: BorderRadius.circular(12),
                      ),child: Image.asset(AppImage.twitterImage),),
                  ],),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 6.0.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New User?',
                          textAlign: TextAlign.center,
                          style: AppStyle.textStyle14WhiteW400,),
                        TextButton(onPressed: (){
                        //  context.pushScreen( LoginScreen());
                        }, child:   Text('Sign Up',
                          textAlign: TextAlign.center,
                          style: AppStyle.textStyle14PrimaryW400,),)
                      ],
                    ),
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
