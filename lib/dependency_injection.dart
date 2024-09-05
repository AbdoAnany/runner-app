

import 'package:get_it/get_it.dart';

import 'features/4_history/data/repositories/history_repository.dart';
import 'features/4_history/data/services/history_service.dart';
import 'features/4_history/domain/repositories/history_repository.dart';
import 'features/4_history/domain/use_cases/usecases/get_history_data.dart';
import 'features/4_history/domain/use_cases/usecases/set_history_data.dart';
import 'features/4_history/presentation/manager/bloc/runner_data_bloc.dart';


final locator = GetIt.instance;

void setupLocator() {


  // History services locators
  historyServiceLocator();



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
  locator.registerFactory<RunnerHistoryDataBloc>(() => RunnerHistoryDataBloc(locator(),locator()),
  );
}
