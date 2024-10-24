import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:runner_app/dependency_injection.dart';

import '../../../../core/widgets/loading_widget.dart';
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
  ProfileListItemModel(icon: Iconsax.logout_1, text: 'Log Out', onTap:
      () =>
      locator<AuthBloc>().add(
        SignOutEvent(userId: FirebaseAuth.instance.currentUser!.uid),)

  ),
];


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    locator<AuthBloc>().add(
        GetCurrentUserEvent(userId: FirebaseAuth.instance.currentUser!.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {

        if (state is AuthLoading) {
          return  LoadingWidget();
        } else if (state is Authenticated) {
          return Column(
            children: [
               HeaderProfile(
                userData:state.user

              ),
              ProfileBodyList(profileItems: profileItems.sublist(0, 4),),
              ProfileBodyList(profileItems: profileItems.sublist(4),),

            ],
          );
        }
        return Container();

      },
    );
  }
}


class ProfileListItemModel {
  final IconData icon;
  final String text;
  final void Function()? onTap;

  ProfileListItemModel({required this.icon, required this.text, this.onTap,});
}
