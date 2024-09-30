// blocs/runner_data/runner_data_state.dart
import '../../../../../core/helper/game.dart';
import '../../../../3_home/presentation/widgets/home_progress_level_steps_bar.dart';
import '../../../domain/entities/history_entity.dart';

abstract class HistoryDataState {}

class HistoryDataLoading extends HistoryDataState {}

class HistoryDataLoaded extends HistoryDataState {
  final List<HistoryEntity> historyData;
 final LevelSystem levelSystem;
  HistoryDataLoaded(this.historyData,this.levelSystem);
}


class SaveDataLoaded extends HistoryDataState {
   final HistoryEntity? historyData;

   SaveDataLoaded(this.historyData);
}

class HistoryDataError extends HistoryDataState {
  final String message;

  HistoryDataError(this.message);
}
