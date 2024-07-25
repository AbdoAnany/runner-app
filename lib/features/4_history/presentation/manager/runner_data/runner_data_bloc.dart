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
        print("LoadRunnerData...");
        final historyData = await getHistoryData();
        print("historyData.length") ;
        print(historyData.length) ;
        emit(RunnerDataLoaded(historyData));
      } catch (e) {
        print("RunnerDataError...");
        print(e.toString());
        emit(RunnerDataError(e.toString()));
      }
    });
  }
}
