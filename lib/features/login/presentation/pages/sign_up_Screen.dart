import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../manager/auth/auth_bloc.dart';
import '../manager/auth/auth_event.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _selectedRole = 'user';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 12.h,),

                Image.asset(AppImage.logoImage, height: 100.h, width:100.w ,),
                SizedBox(height: 32.h,),
                Text('Sign Up',
                  style: AppStyle.textStyle21WhiteW700,),
                SizedBox(height: 12.h,),

                TextFormField(   style: TextStyle(color: AppColors.white),
                  controller: _emailController,
                  decoration:AppStyle. inputDecoration(hintText: 'email'),

                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(   style: TextStyle(color: AppColors.white),
                  controller: _passwordController,
                  decoration:AppStyle. inputDecoration(hintText: 'password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(   style: TextStyle(color: AppColors.white),
                  controller: _confirmPasswordController,
                  decoration:AppStyle. inputDecoration(hintText: 'confirm password'),

                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedRole,style: TextStyle(color: AppColors.white),

                  decoration:AppStyle. inputDecoration(hintText: 'role'),
                  dropdownColor: AppColors.bgContainerColor,
                  items: ['user', 'admin'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRole = newValue!;
                    });
                  },
                ),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: MaterialButton(
                    minWidth: 326.w,elevation: 0,
                    color: AppColors.primary,
                    height: 56.h,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

                    child: Text("Sign Up",style:AppStyle.textStyle18WhiteW700,),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();
                        BlocProvider.of<AuthBloc>(context).add(
                          SignUpRequested(email, password, _selectedRole),
                        );
                      }
                    },),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}