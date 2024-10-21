import 'package:runner_app/features/2_auth/data/models/user_model.dart';

import '../../domain/entities/history_entity.dart';
import '../../domain/repositories/history_repository.dart';
import '../models/history_data_model.dart';
import '../services/history_service.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryService service;

  HistoryRepositoryImpl(this.service);

  @override
  Future<List<HistoryEntity>> getHistoryData() async {
    final data = await service.getHistoryData();


    return data.map((e) => HistoryDataModel.fromMap(e)).toList();
  }

  @override
  Future<void> setHistoryData(List<HistoryEntity> historyData) async {
    final data =
    historyData.map((e) => (e as HistoryDataModel).toMap()).toList();
    await service.setHistoryData(data);
  }

  @override
  Future<bool> addHistoryEntry(HistoryEntity entry) async {
 final res =   await service.addHistoryEntry((entry as HistoryDataModel).toMap());
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
  Future<List<UserModel>> getAllUsersDataList() async {
    // TODO: implement getAllUsersDataList
   return await service.getAllUsersDataList();
  }
}
