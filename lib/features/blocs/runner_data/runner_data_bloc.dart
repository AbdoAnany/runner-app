
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:runner_app/features/blocs/runner_data/runner_data_event.dart';
import 'package:runner_app/features/blocs/runner_data/runner_data_state.dart';


import '../../services/runner_data_service.dart';

class RunnerDataBloc extends Bloc<RunnerDataEvent, RunnerDataState> {
  final RunnerDataService _runnerDataService;

  RunnerDataBloc(this._runnerDataService) : super(RunnerDataLoading()) {
    on<LoadRunnerData>((event, emit) async {
      try {
        final historyData = await _runnerDataService.getHistoryData();
        final popularData = await _runnerDataService.getPopularData();
        emit(RunnerDataLoaded(historyData, popularData));
      } catch (_) {
        emit(RunnerDataError());
      }
    });
  }
}
