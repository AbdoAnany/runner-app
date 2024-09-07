

import 'package:get_it/get_it.dart';

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

void setupLocator() {


  // History services locators
  homeServiceLocator();
  historyServiceLocator();



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
