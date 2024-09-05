// blocs/runner_data/runner_data_event.dart
import '../../../domain/entities/history_entity.dart';

abstract class RunnerHistoryDataEvent {}

class LoadRunnerData extends RunnerHistoryDataEvent {}

class AddRunnerData extends RunnerHistoryDataEvent {

  final HistoryEntity historyEntity;
  AddRunnerData(this.historyEntity);
}

class DeleteRunnerData extends RunnerHistoryDataEvent {

  final HistoryEntity historyEntity;
  DeleteRunnerData(this.historyEntity);
}
