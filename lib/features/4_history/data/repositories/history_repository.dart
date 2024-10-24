import 'package:runner_app/features/2_auth/data/models/UserDataDataModel.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../domain/entities/history_entity.dart';
import '../../domain/repositories/history_repository.dart';
import '../models/history_data_model.dart';
import '../services/history_service.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryService service;

  HistoryRepositoryImpl(this.service);

  @override
  Future<List<PointHistoryEntity>> getHistoryData() async {
    final data = await service.getHistoryData();


    return data.map((e) => PointUserHistoryDataModel.fromMap(e)).toList();
  }

  @override
  Future<void> setHistoryData(List<PointHistoryEntity> historyData) async {
    final data =
    historyData.map((e) => (e as PointUserHistoryDataModel).toMap()).toList();
    await service.setHistoryData(data);
  }

  @override
  Future<bool> addHistoryEntry(PointHistoryEntity entry) async {
 final res =   await service.addHistoryEntry((entry as PointUserHistoryDataModel).toMap());
return res;
  }

  @override
  Future<void> updateHistoryEntry(
      String date, Map<String, dynamic> updates) async {
    await service.updateHistoryEntry(date, updates);
  }

  @override
  Future<bool> deleteHistoryEntry(String date) async {
 return   await service.deleteHistoryEntry(date);
  }

  @override
  Future<List<UserDataDataModel>> getAllUsersDataList() async {
    // TODO: implement getAllUsersDataList
   return await service.getAllUsersDataList();
  }
}
