

import 'package:get_it/get_it.dart';

import 'features/4_history/data/repositories/history_repository.dart';
import 'features/4_history/data/services/history_service.dart';
import 'features/4_history/domain/repositories/history_repository.dart';
import 'features/4_history/domain/use_cases/usecases/get_history_data.dart';
import 'features/4_history/domain/use_cases/usecases/set_history_data.dart';
import 'features/4_history/presentation/manager/bloc/runner_data_bloc.dart';


final locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton<HistoryService>(() => HistoryService());

  // Register repositories
  locator.registerLazySingleton<HistoryRepository>(() => HistoryRepositoryImpl(locator()),);

  // Register use cases
  locator.registerLazySingleton(() => GetHistoryData(locator()));
  locator.registerLazySingleton<SetHistoryData>(() => SetHistoryData(locator()));

  // Register blocs
  locator.registerFactory(() => RunnerHistoryDataBloc(locator()),
  );
}
