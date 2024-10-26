


import '../../../../core/errors/failure.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../../4_history/data/models/history_data_model.dart';


abstract class UserControlRepository {

  Future<Result<List<UserDataDataModel>>> getUserList();
  Future<Result<UserDataDataModel>> getUserDetails();
  Future<Result<UserDataDataModel>> updateUserDetails();
  Future<Result<bool>> setUserPointData(PointUserHistoryDataModel pointHistoryEntity);
  Future<Result<bool>> deleteUserFromList();

}


