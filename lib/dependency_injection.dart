

import 'package:get_it/get_it.dart';
import 'package:runner_app/features/2_auth/data/repositories/auth_repository_impl.dart';
import 'package:runner_app/features/2_auth/domain/use_cases/login_use_case.dart';
import 'package:runner_app/features/2_auth/presentation/manager/auth/auth_bloc.dart';

import 'core/notification/notification_bloc.dart';
import 'core/service/NotificationService.dart';
import 'features/2_auth/data/datasources/auth_remote_data_source.dart';
import 'features/2_auth/domain/repository/auth_repository.dart';
import 'features/2_auth/domain/use_cases/sign_up_use_case.dart';
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
import 'main.dart';


final locator = GetIt.instance;

void setupLocator() {

  authServiceLocator();
  notificationServiceLocator();
  // History services locators
  homeServiceLocator();
  historyServiceLocator();

//   final notificationBloc = NotificationBloc();
//   final notificationService = NotificationService(notificationBloc);
//   await notificationService.initialize();


}
Future<void> authServiceLocator() async {
  // History services

  locator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource());
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(locator()));
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator()));
  locator.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(locator()));

  locator.registerLazySingleton<AuthBloc>(() => AuthBloc(loginUseCase:locator() ,signUpUseCase:locator() ));

}
Future<void> notificationServiceLocator() async {
  // History services
  locator.registerLazySingleton<NotificationBloc>(() => NotificationBloc());
  locator.registerLazySingleton<NotificationService>(() => NotificationService(locator()));
  // await locator<NotificationService>().initialize();

}

void homeServiceLocator() {
  // History services
  locator.registerLazySingleton<UserDataService>(() => UserDataService());

  // History repositories
  locator.registerLazySingleton<UserDataRepository>(() => UserDataRepositoryImpl(locator()),);

  // History use cases
  locator.registerLazySingleton<GetUserData>(() => GetUserData(locator()));
  locator.registerLazySingleton<SetUserData>(() => SetUserData(locator()));

  // History blocs
  locator.registerFactory<HomeBloc>(() => HomeBloc(getUserData: locator(),setUserData:locator() ),
  );
}
void historyServiceLocator() {
  // History services
  locator.registerLazySingleton<HistoryService>(() => HistoryService());

  // History repositories
  locator.registerLazySingleton<HistoryRepository>(() => HistoryRepositoryImpl(locator()),);

  // History use cases
  locator.registerLazySingleton<GetHistoryData>(() => GetHistoryData(locator()));
  locator.registerLazySingleton<SetHistoryData>(() => SetHistoryData(locator()));

  // History blocs
  locator.registerFactory<HistoryDataBloc>(() => HistoryDataBloc(
    homeBloc: locator(),
      getHistoryData: locator(), setHistoryData: locator()),
  );
}
