import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:runner_app/core/const/const.dart';
import 'package:runner_app/core/helper/extension.dart';
import 'package:runner_app/core/share/main_Screen.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:runner_app/features/2_auth/presentation/pages/sign_up_Screen.dart';
import 'package:runner_app/features/home/presentation/pages/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/style/app_style.dart';

import '../manager/auth/auth_bloc.dart';
import '../manager/auth/auth_event.dart';
import '../manager/auth/auth_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }
  void changeObscureText(){
    setState(() {
      obscureText = !obscureText;
    });
  }

  void _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailController.text = prefs.getString('email') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      if(_rememberMe&& FirebaseAuth.instance.currentUser!=null){
        context.pushScreen(MainScreen(user: FirebaseAuth.instance.currentUser,));
      }
    });
  }

  void _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      prefs.setString('email', _emailController.text);
      prefs.setString('password', _passwordController.text);
      prefs.setBool('rememberMe', true);
    } else {
      prefs.remove('email');
      prefs.remove('password');
      prefs.setBool('rememberMe', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
leading: SizedBox(),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc  , AuthState>(
          listener: (BuildContext context, AuthState state) {

            if (state is Authenticated) {
              context.pushScreen(MainScreen(user: state.user,));
            }else if (state is Unauthenticated||state is AuthError) {
              toastification.show(
                alignment: Alignment.bottomCenter,
                context: context, // optional if you use ToastificationWrapper
                title: Text('email or password is not correct'),
                type: ToastificationType.error,
                style: ToastificationStyle.flatColored,
                autoCloseDuration: const Duration(seconds: 3),
              );
            }
            // else if (state is AuthError) {
            //   toastification.show(
            //     alignment: Alignment.bottomCenter,
            //     context: context, // optional if you use ToastificationWrapper
            //     title: Text(state.message),
            //     type: ToastificationType.error,
            //     style: ToastificationStyle.flatColored,
            //     autoCloseDuration: const Duration(seconds: 3),
            //   );
            // }

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
                    decoration:    AppStyle.inputDecoration(hintText: 'email'),),

                  SizedBox(height: 12.h,),
                  TextField(
                    controller: _passwordController,
                    style: TextStyle(color: AppColors.white),
                    decoration:
                    InputDecoration(
                        filled: true,
                        hintText:  'password',hintStyle:  TextStyle(color: AppColors.textGray),

                        fillColor: AppColors.bgFiledColor,
                        suffix: InkWell(child: Icon(obscureText ?
                        Iconsax.eye  : Iconsax.eye_slash, color: AppColors.white,),
                          onTap: (){
                            changeObscureText();
                          },),
                        border: OutlineInputBorder(

                          borderSide: BorderSide(color: AppColors.primary),

                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primary.withOpacity(.8)),

                          borderRadius: BorderRadius.circular(10),
                        )
                    ),



                    obscureText: obscureText,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      Text('Remember me', style: AppStyle.textStyle14WhiteW400),

                      Spacer(),
                      TextButton(onPressed: () async {
                        _forgotPassword(context);
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
                        _saveCredentials();
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpScreen()));
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



void _forgotPassword(BuildContext context) async {
  String email = _emailController.text.trim();
  if (email.isEmpty) {
    // Show error that email is required
    return;
  }
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // Show success message
  } catch (e) {
    // Show error message
  }
}
}

