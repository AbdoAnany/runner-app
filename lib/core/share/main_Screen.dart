import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:runner_app/core/share/share_app_bar.dart';
import 'package:runner_app/core/style/app_style.dart';
import 'package:runner_app/features/2_auth/presentation/manager/auth/auth_event.dart';

import '../../dependency_injection.dart';
import '../../features/2_auth/presentation/manager/auth/auth_bloc.dart';
import '../../features/3_home/presentation/pages/home_screen.dart';
import '../../features/4_history/presentation/manager/runner_data/runner_data_bloc.dart';
import '../../features/4_history/presentation/pages/history_screen.dart';
import '../../features/5_store/presentation/pages/popular_section.dart';
import '../const/const.dart';
import '../style/color.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    this.child = const SizedBox(),
    this.screenName = 'home',
    this.user,
  }) : super(key: key);

  final Widget child;
  final String screenName;
  final User? user;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Map<String, Widget>> _pages = [
    {
      "Home": const HomeScreen(),
    },
    {
      "History":  BlocProvider<RunnerHistoryDataBloc>(
        create: (context) => locator<RunnerHistoryDataBloc>(),
        child: const HistoryScreen(),
      ),
    },
    {
      "Store": StoreScreen(),
    },
    {
      "Profile": ProfileScreen(),
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: ShareAppBar(onTap:()=> _onItemTapped,
      title: _pages[_currentIndex].keys.first,
        currentIndex: _currentIndex,
      ),
      body: Stack(
        children: [
          if (_currentIndex == 0)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 380.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImage.homeGrenadianImage),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
              ),
            ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImage.bgPurpple),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImage.bgPink),
                fit: BoxFit.fill,
              ),
            ),
          ),
          AnimatedSwitcher(
              duration: Duration(milliseconds: 800),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(animation),
                  child: child,
                );
              },
              child: _pages[_currentIndex].values.first),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(colors: [
            AppColors.bgFiledColor,
            AppColors.bgFiledColor,
          ]),
          border: Border.all(color: AppColors.white.withOpacity(.17)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowContainerColor.withOpacity(.05),
              spreadRadius: 0,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: AppColors.primary.withOpacity(.24),
              spreadRadius: 0,
              blurRadius: 24,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 40),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GradientIcon(
              icon: Iconsax.home_25,
              isSelected: _currentIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            GradientIcon(
              icon: Iconsax.cup5,
              isSelected: _currentIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            GradientIcon(
              icon: Iconsax.shopping_bag,
              isSelected: _currentIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            GradientIcon(
              icon: Iconsax.user,
              isSelected: _currentIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon({
    Key? key,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: isSelected
                ? [AppColors.primary, AppColors.dotColor]
                : [AppColors.iconHomeColor, AppColors.iconHomeColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        child: Icon(
          icon,
          color: AppColors.iconHomeColor,
          size: 32.w,
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImage.bgPurpple),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("ProfileScreen", style: AppStyle.textStyle12GrayW400),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
              child: Text("Logout", style: AppStyle.textStyle20GoldW800),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  SignOutRequested(),
                );
              })
        ],
      ),
    );
  }
}
