
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/Result.dart';
import '../../../data/models/user_data_model.dart';
import '../../../presentation/widgets/home_progress_level_steps_bar.dart';
import '../../repositories/user_data_repository.dart';

class SetUserData {
  final UserDataRepository repository;

  SetUserData(this.repository);

  Future<void> call(UserDataDataModel userData) async {

    await repository.setUserDataData(userData);
  }

  Future<bool> updateUserData(UserDataDataModel userData) async {

  final result =  await repository.updateUserDataEntry(updates: userData.toMap(),userId: userData.userId);
  return result.value!;
  }

  Future<bool> updateLevelData(LevelSystem levelSystem) async {

  final result =  await repository.updateLevelData(levelSystem.toJson());
  return result;
  }

  Future<bool> deleteHistoryEntry(UserDataDataModel userData) async {

  final result =  await repository.deleteUserDataEntry(userData.userId);
  return result;
  }
}
