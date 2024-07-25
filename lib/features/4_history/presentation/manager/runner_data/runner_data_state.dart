// blocs/runner_data/runner_data_state.dart
import '../../../data/entities/history_entity.dart';

abstract class RunnerHistoryDataState {}

class RunnerDataLoading extends RunnerHistoryDataState {}

class RunnerDataLoaded extends RunnerHistoryDataState {
  final List<HistoryEntity> historyData;

  RunnerDataLoaded(this.historyData);
}

class RunnerDataError extends RunnerHistoryDataState {
  final String message;

  RunnerDataError(this.message);
}
