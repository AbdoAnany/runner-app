


import 'package:runner_app/features/2_auth/data/models/user_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../2_auth/data/models/UserDataDataModel.dart';


abstract class UserControlRepository {

  Future<Result<List<UserDataDataModel>>> getUserList();
  Future<Result<UserDataDataModel>> getUserDetails();
  Future<Result<UserDataDataModel>> updateUserDetails();
  Future<Result<bool>> deleteUserFromList();

}


