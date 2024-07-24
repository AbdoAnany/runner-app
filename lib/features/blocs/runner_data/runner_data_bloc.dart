
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:runner_app/features/blocs/runner_data/runner_data_event.dart';
import 'package:runner_app/features/blocs/runner_data/runner_data_state.dart';


import '../../services/runner_data_service.dart';

class RunnerDataBloc extends Bloc<RunnerDataEvent, RunnerDataState> {
  // final RunnerDataService _runnerDataService;
  final HistoryService _historyService;

  RunnerDataBloc(this._historyService) : super(RunnerDataLoading()) {
    on<LoadRunnerData>((event, emit) async {
      try {
        final historyData = await _historyService.getHistoryData();
      //  final popularData = await _runnerDataService.getPopularData();
        emit(RunnerDataLoaded(historyData, []));
      } catch (_) {
        emit(RunnerDataError());
      }
    });
  }
}
