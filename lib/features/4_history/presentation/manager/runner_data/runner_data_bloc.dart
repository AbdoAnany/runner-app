// blocs/runner_data/runner_data_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/function.dart';
import '../../../../../dependency_injection.dart';
import '../../../domain/use_cases/usecases/get_history_data.dart';
import '../../../domain/use_cases/usecases/set_history_data.dart';
import 'runner_data_event.dart';
import 'runner_data_state.dart';

class RunnerHistoryDataBloc extends Bloc<RunnerHistoryDataEvent, RunnerHistoryDataState> {
  final GetHistoryData getHistoryData;

  RunnerHistoryDataBloc(this.getHistoryData) : super(RunnerDataLoading()) {

    on<LoadRunnerData>((event, emit) async {
      try {

        var historyData = await getHistoryData();
        if(historyData.isEmpty){
             historyData=  AppFunction.generateFakeHistoryData(10).toList();

       await  locator<SetHistoryData>().call(historyData);
              // historyData = await getHistoryData();

        }
        emit(RunnerDataLoaded(historyData));
      } catch (e) {
        emit(RunnerDataError(e.toString()));
      }
    });
  }
}
