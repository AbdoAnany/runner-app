import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:runner_app/features/3_home/presentation/pages/home_screen.dart';

import 'dependency_injection.dart';
import 'features/2_auth/presentation/manager/auth/auth_bloc.dart';
import 'features/2_auth/presentation/pages/SignInPage.dart';
import 'features/3_home/presentation/bloc/home_bloc.dart';
import 'firebase_options.dart';
import 'my_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'features/authentication/presentation/bloc/auth_bloc.dart';
// import 'features/authentication/presentation/pages/sign_in_page.dart';
import 'features/2_auth/presentation/pages/sign_up_Screen.dart';
import 'dependency_injection.dart' as di;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  await ScreenUtil.ensureScreenSize();
  // await di.init();
  await setupLocator();
  runApp(MyApp());
}




