// blocs/runner_data/runner_data_bloc.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runner_app/my_app.dart';

import '../../../../../core/helper/function.dart';
import '../../../../../dependency_injection.dart';
import '../../../domain/entities/history_entity.dart';
import '../../../domain/use_cases/usecases/get_history_data.dart';
import '../../../domain/use_cases/usecases/set_history_data.dart';
import 'runner_data_event.dart';
import 'runner_data_state.dart';

class RunnerHistoryDataBloc extends Bloc<RunnerHistoryDataEvent, RunnerHistoryDataState> {
  final GetHistoryData getHistoryData;
  final SetHistoryData setHistoryData;

  RunnerHistoryDataBloc(this.getHistoryData, this.setHistoryData) : super(RunnerDataLoading()) {
    on<LoadRunnerData>((event, emit) async {
      try {
        var historyData = await getHistoryData.call();

        historyData.sort((a, b) => b.date.compareTo(a.date));
        emit(RunnerDataLoaded(historyData));
      } catch (e) {

        emit(RunnerDataError(e.toString()));
      }
    });

    on<AddRunnerData>((event, emit) async {
      try {


        if (state is RunnerDataLoaded) {
          final List<HistoryEntity> currentData = List.from((state as RunnerDataLoaded).historyData);
          currentData.insert(0,event.historyEntity);
          await setHistoryData.addHistoryEntry(event.historyEntity);
          emit(RunnerDataLoaded(currentData));
        }
      } catch (e) {
        emit(RunnerDataError(e.toString()));
      }
    });


    on<DeleteRunnerData>((event, emit) async {
      try {


        if (state is RunnerDataLoaded) {
          final List<HistoryEntity> currentData = List.from((state as RunnerDataLoaded).historyData);
          print('DeleteRunnerDataDeleteRunnerDataDeleteRunnerDataDeleteRunnerDataDeleteRunnerDataDeleteRunnerData');
          print(currentData.length);
          currentData.removeWhere((element) => element.id ==event.historyEntity.id);
          print(currentData.length);
          await setHistoryData.deleteHistoryEntry(event.historyEntity);
          // Emit the updated state with sorted data
          emit(RunnerDataLoaded(currentData));
        }
      } catch (e) {
        print(e);
        emit(RunnerDataError(e.toString()));
      }
    });
  }
}
