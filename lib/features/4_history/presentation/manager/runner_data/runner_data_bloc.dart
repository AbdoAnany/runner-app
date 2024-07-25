// blocs/runner_data/runner_data_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/usecases/get_history_data.dart';
import 'runner_data_event.dart';
import 'runner_data_state.dart';

class RunnerHistoryDataBloc extends Bloc<RunnerHistoryDataEvent, RunnerHistoryDataState> {
  final GetHistoryData getHistoryData;

  RunnerHistoryDataBloc(this.getHistoryData) : super(RunnerDataLoading()) {

    on<LoadRunnerData>((event, emit) async {
      try {
        final historyData = await getHistoryData();
        emit(RunnerDataLoaded(historyData));
      } catch (e) {
        emit(RunnerDataError(e.toString()));
      }
    });
  }
}
