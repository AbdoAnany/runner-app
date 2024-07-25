import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';


import '../../../../core/const/const.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/style/color.dart';
import '../../../2_auth/presentation/manager/auth/auth_bloc.dart';
import '../../../2_auth/presentation/manager/auth/auth_event.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Information',
              style: AppStyle.textStyle16GWhiteW800
            ),
            SizedBox(height: 20),
            Text(
              'Name: ${FirebaseAuth.instance.currentUser?.email?.split('@').first}',
                style: AppStyle.textStyle12WhiteW400
            ),
            Text(
              'Email:  ${FirebaseAuth.instance.currentUser?.email}',
                style: AppStyle.textStyle12WhiteW400
            ),       Text(
                'lastSignInTime: ${FirebaseAuth.instance.currentUser?.metadata.lastSignInTime}',
                style: AppStyle.textStyle12WhiteW400
            ),

            Text(
                'displayName: ${FirebaseAuth.instance.currentUser?.displayName}',
                style: AppStyle.textStyle12WhiteW400
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  SignOutRequested(),
                );
              },
              child: Text('Logout'),
            ),
            MaterialButton(
              onPressed: () {
                // Add change account role functionality here
              },
              child: Text('Change Account Role'),
            ),
          ],
        ),
      ),
    );
  }
}
