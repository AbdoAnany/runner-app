import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:runner_app/dependency_injection.dart';
import 'package:runner_app/features/0_get_started/presentation/pages/get_started_screen.dart';
import 'package:toastification/toastification.dart';

import 'core/notification/notification_bloc.dart';
import 'features/2_auth/presentation/manager/auth/auth_bloc.dart';
import 'features/2_auth/presentation/pages/PhoneScreen.dart';
import 'features/2_auth/presentation/pages/SignInPage.dart';
import 'features/2_auth/presentation/pages/SignUpScreen.dart';
import 'features/2_auth/presentation/pages/login_screen.dart';
import 'features/2_auth/presentation/pages/otp_verification .dart';
import 'features/2_auth/presentation/pages/sign_up_Screen.dart';
import 'features/3_home/presentation/pages/home_screen.dart';
import 'features/main_Screen.dart';

class Get {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;
  static NavigatorState get navigator => navigatorKey.currentState!;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (context) => locator<AuthBloc>()),
          BlocProvider<NotificationBloc>(
            create: (context) => locator<NotificationBloc>(),
          ),

        ],

        child: ScreenUtilInit(
          designSize: const Size(375, 768),
          // minTextAdapt: true,
          // splitScreenMode: true,
          // Use builder only if you need to use library outside ScreenUtilInit context
          builder: (ctx, child) {
            ScreenUtil.init(ctx);
            return ToastificationWrapper(
              child: MaterialApp(
                navigatorKey: Get.navigatorKey,
                title: 'Runner App',
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.dark,
                theme: ThemeData(
                  primarySwatch: Colors.deepPurple,

                  scaffoldBackgroundColor: AppColors.bgColor,
                  appBarTheme: const AppBarTheme(
                    color: AppColors.bgColor,
                    //    backgroundColor: AppColors.bgColor,

                    iconTheme: IconThemeData(color: AppColors.white),
                  ),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                routes: {
                  '/home': (context) => const MainScreen(),
                  // '/signup': (context) => const SignUpScreen(),
                  '/phone': (context) => PhoneScreen(),
                  '/verification': (context) => VerificationScreen(),
                  // Add other routes
                },
                home: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      return BlocBuilder<AuthBloc, AuthState>(
                        // listener: (context, state) {
                        //   if (state is Authenticated) {
                        //     Navigator.of(context).pushReplacementNamed('/home');
                        //   } else if (state is AuthError) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(content: Text(state.message)),
                        //     );
                        //   }
                        // },
                        builder: (context, state) {

                          if (state is Authenticated) {
                            return const MainScreen();
                          } else {
                            return  const LoginScreen();
                            //       return const GetStarted();
                          }
                        },
                      );
                    }),
              ),
            );
          },
        )
        //  child: const HomePage(title: 'First Method'),

        );
  }
}
