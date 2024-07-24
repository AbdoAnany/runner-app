import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:runner_app/features/get_started/presentation/pages/get_started_screen.dart';
import 'package:toastification/toastification.dart';

import 'features/blocs/runner_data/runner_data_bloc.dart';
import 'features/login/data/repositories/firebase_auth.dart';
import 'features/login/presentation/manager/auth/auth_bloc.dart';
import 'features/login/presentation/manager/auth/auth_state.dart';
import 'features/services/runner_data_service.dart';
import 'features/ui/screens/home_screen.dart';
import 'features/login/presentation/pages/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthService()),
        ),
        BlocProvider<RunnerDataBloc>(
          create: (context) => RunnerDataBloc(RunnerDataService()),
        ),
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
              title: 'Runner App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
                scaffoldBackgroundColor:AppColors.bgColor,
                appBarTheme:  AppBarTheme(
                  color: AppColors.bgColor,
              //    backgroundColor: AppColors.bgColor,
                  iconTheme: IconThemeData(color: AppColors.white),),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    return HomeScreen(user: state.user);
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
