import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/const/const.dart';
import 'package:runner_app/core/helper/extension.dart';
import 'package:runner_app/core/widgets/loading_widget.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/utils/Validators.dart';
import '../../../../core/widgets/main_buttom.dart';
import '../manager/auth/auth_bloc.dart';

import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/role_dropdown.dart';

class SignUpScreen1 extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen1> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _selectedRole = 'user';
  List<String> roles = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print("initStat e 1");

    BlocProvider.of<AuthBloc>(context).add(LoadRolesRequestedEvent());
    print("initStat e 2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is RolesLoaded) {
              roles = state.roles;
            }

            // if (state is AuthError) {
            //   toastification.show(
            //     alignment: Alignment.bottomCenter,
            //     context: context, // optional if you use ToastificationWrapper
            //     title: Text(state.message),
            //     type: ToastificationType.error,
            //     style: ToastificationStyle.flatColored,showProgressBar: false,
            //     autoCloseDuration: const Duration(seconds: 3),
            //   );
            //
            // }
            if (state is SignUpRequestedDone) {
              toastification.show(
                alignment: Alignment.bottomCenter,
                context: context, // optional if you use ToastificationWrapper
                title: const Text('sign up successfully'),
                type: ToastificationType.success,
                style: ToastificationStyle.flatColored, showProgressBar: false,
                autoCloseDuration: const Duration(seconds: 3),
              );
              context.pop();
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return LoadingWidget();
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 12.h, bottom: 32.h),
                      child: Image.asset(
                        AppImage.logoImage,
                        height: 100.h,
                        width: 100.w,
                      ),
                    ),
                    Text(
                      AppStrings.signUp,
                      style: AppStyle.textStyle21WhiteW700,
                    ),
                    EmailField(controller: _emailController),
                    PasswordField(
                      controller: _passwordController,
                      validator: (value) =>
                          Validators.validatePassword(value ?? ""),
                    ),
                    PasswordField(
                      controller: _confirmPasswordController,
                      hintText: AppStrings.confirmPassword,
                      validator: (value) => Validators.confirmPassword(
                          value, _passwordController.text),
                    ),
                    RoleDropdown(
                      roles: roles,
                      selectedRole: _selectedRole,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRole = newValue!;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: MyMaterialButton(
                        width: 326.w,
                        title: AppStrings.signUp,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            BlocProvider.of<AuthBloc>(context).add(
                              SignUpWithEmailEvent(
                                  email: email,
                                  password: password,roles: _selectedRole),

                            );
                            // AuthBloc.runEvent(
                            //   SignUpRequested(email, password, _selectedRole),
                            // );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
            return Container(); // Return an empty container for other states
          },
        ),
      ),
    );
  }
}

// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   String _selectedRole = 'user';
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 12.h,),
//
//                 Image.asset(AppImage.logoImage, height: 100.h, width:100.w ,),
//                 SizedBox(height: 32.h,),
//                 Text('Sign Up',
//                   style: AppStyle.textStyle21WhiteW700,),
//                 SizedBox(height: 12.h,),
//
//                 TextFormField(   style: TextStyle(color: AppColors.white),
//                   controller: _emailController,
//                   decoration:AppStyle. inputDecoration(hintText: 'email'),
//
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 TextFormField(   style: TextStyle(color: AppColors.white),
//                   controller: _passwordController,
//                   decoration:AppStyle. inputDecoration(hintText: 'password'),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a password';
//                     }
//                     if (value.length < 6) {
//                       return 'Password must be at least 6 characters long';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 TextFormField(   style: TextStyle(color: AppColors.white),
//                   controller: _confirmPasswordController,
//                   decoration:AppStyle. inputDecoration(hintText: 'confirm password'),
//
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please confirm your password';
//                     }
//                     if (value != _passwordController.text) {
//                       return 'Passwords do not match';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 DropdownButtonFormField<String>(
//                   value: _selectedRole,style: TextStyle(color: AppColors.white),
//
//                   decoration:AppStyle. inputDecoration(hintText: 'role'),
//                   dropdownColor: AppColors.bgContainerColor,
//                   items: ['user', 'admin'].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _selectedRole = newValue!;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 24),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 12.h),
//                   child: MaterialButton(
//                     minWidth: 326.w,elevation: 0,
//                     color: AppColors.primary,
//                     height: 56.h,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//
//                     child: Text("Sign Up",style:AppStyle.textStyle18WhiteW700,),
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         final email = _emailController.text.trim();
//                         final password = _passwordController.text.trim();
//                         BlocProvider.of<AuthBloc>(context).add(
//                           SignUpRequested(email, password, _selectedRole),
//                         );
//                       }
//                     },),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
