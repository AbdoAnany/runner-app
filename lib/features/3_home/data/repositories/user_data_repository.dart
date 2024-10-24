import '../../domain/repositories/user_data_repository.dart';
import '../models/user_data_model.dart';
import '../services/user_data_service.dart';

class UserDataRepositoryImpl implements UserDataRepository {
  final UserDataService service;

  UserDataRepositoryImpl(this.service);

  @override
  Future<UserDataDataModel> getUserDataData() async {
    final data = await service.getUserDataData();


    return UserDataDataModel.fromJson(data!);
  }

  @override
  Future<void> setUserDataData(UserDataDataModel userDataData) async {
    final data = userDataData.toMap();
    await service.setUserDataData(data);
  }

  @override
  Future<bool> addUserDataEntry(UserDataDataModel entry) async {
 final res =   await service.addUserDataEntry((entry).toMap());
return res;
  }

  @override
  Future<bool> updateUserDataEntry(
      Map<String, dynamic> updates) async {
return    await service.updateUserDataEntry(updates);
  }

  @override
  Future<bool> deleteUserDataEntry(String date) async {
 return   await service.deleteUserDataEntry(date);
  }

  @override
  Future<bool> updateLevelData(Map<String, dynamic> updates) async {
    return    await service.updateLevelData(updates);
  }
}
