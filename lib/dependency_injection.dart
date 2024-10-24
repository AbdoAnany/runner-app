import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:runner_app/features/10_user_point_control/data/repositories/UserControlRepository.dart';
import 'package:runner_app/features/2_auth/domain/use_cases/clear_user_date_cached.dart';
import 'package:runner_app/features/2_auth/presentation/manager/auth/auth_bloc.dart';

import 'core/notification/notification_bloc.dart';
import 'core/service/NotificationService.dart';
import 'features/10_user_point_control/data/data_sources/UserPointControlService.dart';
import 'features/10_user_point_control/domain/repositories/user_control_repo.dart';
import 'features/10_user_point_control/domain/use_cases/get_user_list.dart';
import 'features/10_user_point_control/domain/use_cases/set_user_point_data.dart';
import 'features/10_user_point_control/presentation/manager/userpoint_bloc.dart';
import 'features/2_auth/data/datasources/firebase_auth_remote_data_source.dart';
import 'features/2_auth/data/repositories/FirebaseAuthRepositoryImpl.dart';
import 'features/2_auth/domain/repositories/FirebaseAuthRemoteDataSource.dart';
import 'features/2_auth/domain/repositories/auth_repository.dart';
import 'features/2_auth/domain/use_cases/create_profile.dart';
import 'features/2_auth/domain/use_cases/get_cached_user.dart';
import 'features/2_auth/domain/use_cases/get_current_user.dart';
import 'features/2_auth/domain/use_cases/role_load.dart';
import 'features/2_auth/domain/use_cases/save_cached_user.dart';
import 'features/2_auth/domain/use_cases/sign_in_with_email.dart';
import 'features/2_auth/domain/use_cases/sign_in_with_google.dart';
import 'features/2_auth/domain/use_cases/sign_out.dart';
import 'features/2_auth/domain/use_cases/sign_up_with_email.dart';
import 'features/3_home/data/repositories/user_data_repository.dart';
import 'features/3_home/data/services/user_data_service.dart';
import 'features/3_home/domain/repositories/user_data_repository.dart';
import 'features/3_home/domain/use_cases/usecases/get_user_data.dart';
import 'features/3_home/domain/use_cases/usecases/set_user_data.dart';
import 'features/3_home/presentation/bloc/home_bloc.dart';
import 'features/4_history/data/repositories/history_repository.dart';
import 'features/4_history/data/services/history_service.dart';
import 'features/4_history/domain/repositories/history_repository.dart';
import 'features/4_history/domain/use_cases/usecases/get_history_data.dart';
import 'features/4_history/domain/use_cases/usecases/set_history_data.dart';
import 'features/4_history/presentation/manager/bloc/runner_data_bloc.dart';

final locator = GetIt.instance;
// final locator = GetIt.instance;

Future<void> init() async {
  // Bloc
  locator.registerLazySingleton(
    () => AuthBloc(
      signInWithEmail: locator(),
      signUpWithEmail: locator(),
      createProfile: locator(),
      signOut: locator(),
      signInWithGoogle: locator(),
      getCurrentUser: locator(),
      clearUserDateCached: locator(),
      getCachedUser: locator(),
      saveCachedUser: locator(),
      rolesLoad: locator(),
    ),
  );
  locator.registerFactory(
    () => UserPointBloc(
     getUserListUseCase: locator(),
      setUserPointData: locator(),homeBloc: locator()
    ),
  );

  // Use cases Auth
  locator.registerLazySingleton(() => SignInWithEmail(locator()));
  locator.registerLazySingleton(() => SignUpWithEmail(locator()));
  locator.registerLazySingleton(() => CreateProfile(locator()));
  locator.registerLazySingleton(() => SignInWithGoogle(locator()));
  locator.registerLazySingleton(() => SignOut(locator()));
  locator.registerLazySingleton(() => GetCurrentUser(locator()));
  locator.registerLazySingleton(() => SaveCachedUser(locator()));
  locator.registerLazySingleton(() => RolesLoad(locator()));
  locator.registerLazySingleton(() => ClearUserDateCached(locator()));
  locator.registerLazySingleton(() => GetCachedUser(locator()));


  // Use cases UserPoint
  locator.registerLazySingleton(() => GetUserListUseCase(locator()));
  locator.registerLazySingleton(() => SetUserPointData(locator()));



  // Repository Auth
  locator.registerLazySingleton<AuthRepository>(() => FirebaseAuthRepositoryImpl(locator()),);

  // Repository UserPoint
  locator.registerLazySingleton<UserControlRepository>(() => UserControlRepositoryImpl(locator()),);

  // Data sources
  locator.registerLazySingleton<FirebaseAuthRemoteDataSource>(
    () => FirebaseAuthRemoteDataSourceImpl(
      firebaseAuth: locator(),
      googleSignIn: locator(),
      facebookAuth: locator(),
      fireStore: locator(),
    ),

  );
  locator.registerLazySingleton<UserPointControlService>(() => UserPointControlService());

  // External
  // locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => GoogleSignIn());
  locator.registerLazySingleton(() => FacebookAuth.instance);
}

Future<void> setupLocator() async {
  await  authServiceLocator();
  await init();
  await  notificationServiceLocator();
  // History services locators
    homeServiceLocator();
    historyServiceLocator();
}

Future<void> authServiceLocator() async {
  // // History services
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  // locator.registerLazySingleton<AuthService>(() => AuthService());
  // locator
  //     .registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(
  //           locator(),
  //           locator(),
  //         ));
  // locator.registerLazySingleton<FirebaseAuthDataSource>(
  //     () => FirebaseAuthDataSource(
  //           locator(),
  //           locator(),
  //         ));
  // locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(locator(),locator(),));

  //  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator()));
  //  locator.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(locator()));
  // locator.registerLazySingleton<AuthBloc>(() => AuthBloc(loginUseCase:locator() ,signUpUseCase:locator() ));
}

Future<void> notificationServiceLocator() async {
  // History services
  locator.registerLazySingleton<NotificationBloc>(() => NotificationBloc());
  locator.registerLazySingleton<NotificationService>(
      () => NotificationService(locator()));
  // await locator<NotificationService>().initialize();
}

void homeServiceLocator() {
  // History services
  locator.registerLazySingleton<UserDataService>(() => UserDataService());

  // History repositories
  locator.registerLazySingleton<UserDataRepository>(
    () => UserDataRepositoryImpl(locator()),
  );

  // History use cases
  locator.registerLazySingleton<GetUserData>(() => GetUserData(locator()));
  locator.registerLazySingleton<SetUserData>(() => SetUserData(locator()));

  // History blocs
  locator.registerFactory<HomeBloc>(
    () => HomeBloc(getUserData: locator(), setUserData: locator()),
  );
}

void historyServiceLocator() {
  // History services
  locator.registerLazySingleton<HistoryService>(() => HistoryService());



  // History repositories
  locator.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(locator()),
  );

  // History use cases
  locator
      .registerLazySingleton<GetHistoryData>(() => GetHistoryData(locator()));
  locator
      .registerLazySingleton<SetHistoryData>(() => SetHistoryData(locator()));

  // History blocs
  locator.registerFactory<HistoryDataBloc>(
    () => HistoryDataBloc(
        homeBloc: locator(),
        getHistoryData: locator(),
        setHistoryData: locator()),
  );
}


