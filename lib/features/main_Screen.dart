import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/share/share_app_bar.dart';
import 'package:runner_app/dependency_injection.dart';
import 'package:runner_app/features/2_auth/presentation/manager/auth/auth_bloc.dart';

import '../../features/3_home/presentation/pages/home_screen.dart';
import '../../features/4_history/presentation/pages/history_screen.dart';
import '../../features/6_profile/presentation/pages/profile_screen.dart';
import '../core/const/const.dart';
import '../core/share/my_bottom_navigation_bar.dart';
import '7_level_gallary/presentation/pages/level_gallery.dart';


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
      "Home": const HomeScreenBlocProvider(),
    },

    {
      "History":  const HistoryScreenBlocProvider()
    },
    {
      "Store":const LevelGallery(),
    },
    {
      "Profile":  ProfileScreen(),
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  void initState() {
    locator<AuthBloc>().add(GetCurrentUserEvent(userId: FirebaseAuth.instance.currentUser!.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(

    canPop: false,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: ShareAppBar(onTap:()=> _onItemTapped(0),
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
                  height: 320.h,
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
                child: SafeArea(

                    child: _pages[_currentIndex].values.first)),
            MyBottomNavigationBar(
              onTap: (e)=> _onItemTapped(e),

              currentIndex: _currentIndex,
            )

          ],
        ),
      //  bottomNavigationBar:
      ),
    );
  }
}


