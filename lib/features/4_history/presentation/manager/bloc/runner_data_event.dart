// blocs/runner_data/runner_data_event.dart
import '../../../../3_home/data/models/user_data_model.dart';
import '../../../domain/entities/history_entity.dart';

abstract class HistoryDataEvent {}

class LoadHistoryData extends HistoryDataEvent {}

class AddHistoryData extends HistoryDataEvent {

  final PointHistoryEntity historyEntity;
  AddHistoryData(this.historyEntity);
}

class DeleteHistoryData extends HistoryDataEvent {

  final PointHistoryEntity historyEntity;
  DeleteHistoryData(this.historyEntity);
}
// Add this event to runner_data_event.dart
class UpdateLevelDataFromHome extends HistoryDataEvent {
  final UserDataDataModel userData;

  UpdateLevelDataFromHome(this.userData);

  @override
  List<Object?> get props => [userData];
}