import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../my_app.dart';
import '../../../2_auth/presentation/manager/auth/auth_bloc.dart';
import '../widgets/header_profile.dart';
import '../widgets/profile_body_list.dart';

final List<ProfileListItemModel> profileItems = [
  ProfileListItemModel(icon: Iconsax.user, text: 'Personal Information'),
  ProfileListItemModel(icon: Iconsax.wallet, text: 'My Wallet'),
  ProfileListItemModel(icon: Iconsax.notification, text: 'Notifications'),
  ProfileListItemModel(icon: Iconsax.language_circle, text: 'Language'),

  ProfileListItemModel(icon: Iconsax.support, text: 'Support'),
  ProfileListItemModel(icon: Iconsax.like_dislike, text: 'Rate App'),
  ProfileListItemModel(icon: Iconsax.message_question, text: 'FAQs'),
  ProfileListItemModel(icon: Iconsax.share, text: 'Share App'),
  ProfileListItemModel(icon: Iconsax.logout_1, text: 'Log Out',onTap:
    () =>BlocProvider.of<AuthBloc>(Get.context).add(SignOutRequested(),)

  ),
];


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderProfile(),
        ProfileBodyList(profileItems:  profileItems.sublist(0, 4),),
        ProfileBodyList(profileItems:  profileItems.sublist(4),),

      ],
    );
  }
}




class ProfileListItemModel {
  final IconData icon;
  final String text;
  final void Function()?  onTap;

  ProfileListItemModel({required this.icon, required this.text,this.onTap, });
}
