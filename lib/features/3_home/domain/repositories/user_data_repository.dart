import 'package:runner_app/core/errors/failure.dart';

import '../../data/models/user_data_model.dart';

abstract class UserDataRepository {
  Future<UserDataDataModel> getUserDataData(userId);
  Future<void> setUserDataData(UserDataDataModel userDataData);
  Future<bool> addUserDataEntry(UserDataDataModel entry);
  Future<Result<bool>> updateUserDataEntry(   {required Map<String, dynamic> updates, required String userId});
  Future<bool> updateLevelData(Map<String, dynamic> updates);
  Future<bool> deleteUserDataEntry(String date);
}



