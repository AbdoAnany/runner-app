import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/const/const.dart';
import 'package:runner_app/core/helper/extension.dart';
import 'package:runner_app/core/widgets/main_buttom.dart';
import 'package:runner_app/features/2_auth/presentation/pages/sign_up_Screen.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/helper/function.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../../core/utils/Validators.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../main_Screen.dart';
import '../manager/auth/auth_bloc.dart';

import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/social_auth_buttons.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (BuildContext context, AuthState state) {
            if (state is Authenticated) {


              context.pushAndReplacementScreen(const MainScreen());
            } else if (state is AuthError) {
              AppFunction.showToast(state.message, type: ToastificationType.error);
            } else if (state is Unauthenticated) {
              AppFunction.showToast('Unauthenticated', type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) return LoadingWidget();

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0.h, bottom: 12.h),
                    child: Image.asset(
                      AppImage.logoImage,
                      height: 100.h,
                      width: 100.w,
                    ),
                  ),
                  Text(
                    AppStrings.login,
                    style: AppStyle.textStyle21WhiteW700,
                  ),
                  SizedBox(height: 12.h),
                  EmailField(controller: _emailController),
                  PasswordField(
                    controller: _passwordController,
                    validator: (value) =>
                        Validators.validatePassword(value ?? ""),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        activeColor: AppColors.primary,
                        onChanged: (value) =>
                            setState(() => _rememberMe = value!),
                      ),
                      Text(AppStrings.remember,
                          style: AppStyle.textStyle14WhiteW400),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          AppStrings.forgot,
                          textAlign: TextAlign.center,
                          style: AppStyle.textStyle14PrimaryW400,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                      ),
                      child: MyMaterialButton(
                        title: AppStrings.login,
                        onPressed: () {
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();
                          BlocProvider.of<AuthBloc>(context).add(
                            SignInWithEmailEvent(
                              email:email,
                              password: password,
                              rememberMe: _rememberMe,
                            ),
                          );
                        },
                        width: 326.w,
                      )),
                  Row(
                    children: [
                      Expanded(
                        child:  Divider(
                          color: AppColors.textGray2,
                          thickness: 0.5,
                        ),
                      ),
                      SizedBox(width: 30.w),
                      Text(
                        AppStrings.continueWith,
                        style: AppStyle.textStyle14GrayerW400,
                      ),
                      SizedBox(width: 30.w),
                      Expanded(
                        child: Divider(
                          color: AppColors.textGray2,
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SocialAuthButtons(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.newUser,
                          textAlign: TextAlign.center,
                          style: AppStyle.textStyle14WhiteW400,
                        ),
                        InkWell(
                          onTap: () {
                            context.pushScreen(SignUpScreen1());
                          },
                          child: Text(
                            AppStrings.signUp,
                            textAlign: TextAlign.center,
                            style: AppStyle.textStyle14PrimaryW400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/phone');
                    },
                    child: Text('Sign By Phone'),
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
