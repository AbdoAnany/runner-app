import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:runner_app/features/0_get_started/presentation/pages/get_started_screen.dart';
import 'package:toastification/toastification.dart';

import 'core/share/main_Screen.dart';
import 'features/2_auth/data/repositories/firebase_auth.dart';
import 'features/2_auth/presentation/manager/auth/auth_bloc.dart';
import 'features/2_auth/presentation/manager/auth/auth_state.dart';
class Get {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;
  static NavigatorState get navigator => navigatorKey.currentState!;

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthService()),
        ),
        // BlocProvider<RunnerDataBloc>(
        //   create: (context) => RunnerDataBloc(HistoryService( )),
        // ),

      ],
      child:
      ScreenUtilInit(
        designSize: const Size(375, 768),
        // minTextAdapt: true,
        // splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (ctx , child) {
          ScreenUtil.init(ctx);
          return  ToastificationWrapper(
            child: MaterialApp(
              navigatorKey: Get.navigatorKey,
              title: 'Runner App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
                scaffoldBackgroundColor:AppColors.bgColor,
                appBarTheme:  const AppBarTheme(
                  color: AppColors.bgColor,
              //    backgroundColor: AppColors.bgColor,
                  iconTheme: IconThemeData(color: AppColors.white),),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    return MainScreen(user: state.user);
                  } else {
                    return const GetStarted();
                  }
                },
              ),
            ),
          );
        },)
      //  child: const HomePage(title: 'First Method'),



    );
  }
}
