import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/core/style/color.dart';
import 'package:runner_app/features/0_get_started/presentation/pages/get_started_screen.dart';
import 'package:runner_app/features/2_auth/data/datasources/auth_remote_data_source.dart';
import 'package:runner_app/features/2_auth/presentation/manager/auth/auth_event.dart';
import 'package:toastification/toastification.dart';

import 'features/2_auth/data/repositories/auth_repository_impl.dart';
import 'features/2_auth/domain/use_cases/login_use_case.dart';
import 'features/2_auth/domain/use_cases/sign_up_use_case.dart';
import 'features/2_auth/presentation/manager/auth/auth_bloc.dart';
import 'features/2_auth/presentation/manager/auth/auth_state.dart';
import 'features/main_Screen.dart';
class Get {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;
  static NavigatorState get navigator => navigatorKey.currentState!;

}
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            loginUseCase: LoginUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
            signUpUseCase: SignUpUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
          )..add(UserIsLogIn()),
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
              home: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {

                  return BlocBuilder<AuthBloc, AuthState>(

                    builder: (context, state) {
                      if (state is Authenticated) {
                        return const MainScreen();
                      } else {
                        return const GetStarted();
                               //       return const GetStarted();
                      }
                    },
                  );
                }
              ),
            ),
          );
        },)
      //  child: const HomePage(title: 'First Method'),



    );
  }
}
