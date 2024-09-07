import '../../data/models/user_data_model.dart';
import '../entities/user_data_entity.dart';

abstract class UserDataRepository {
  Future<UserDataDataModel> getUserDataData();
  Future<void> setUserDataData(UserDataDataModel userDataData);
  Future<bool> addUserDataEntry(UserDataDataModel entry);
  Future<bool> updateUserDataEntry(Map<String, dynamic> updates);
  Future<bool> updateLevelData(Map<String, dynamic> updates);
  Future<bool> deleteUserDataEntry(String date);
}



