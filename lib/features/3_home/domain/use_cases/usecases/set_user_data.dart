
import '../../../../../core/helper/game.dart';
import '../../../data/models/user_data_model.dart';
import '../../../presentation/widgets/home_progress_level_steps_bar.dart';
import '../../entities/user_data_entity.dart';
import '../../repositories/user_data_repository.dart';

class SetUserData {
  final UserDataRepository repository;

  SetUserData(this.repository);

  Future<void> call(UserDataDataModel userData) async {

    await repository.setUserDataData(userData);
  }

  Future<bool> updateUserData(UserDataDataModel userData) async {

  final result =  await repository.updateUserDataEntry(userData.toMap());
  return result;
  }  Future<bool> updateLevelData(LevelSystem levelSystem) async {

  final result =  await repository.updateLevelData(levelSystem.toJson());
  return result;
  }

  Future<bool> deleteHistoryEntry(UserDataDataModel userData) async {

  final result =  await repository.deleteUserDataEntry(userData.userId);
  return result;
  }
}
