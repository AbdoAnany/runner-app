import 'package:runner_app/core/errors/failure.dart';
import 'package:runner_app/features/3_home/data/models/user_data_model.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../4_history/data/models/history_data_model.dart';
import '../../../4_history/domain/entities/history_entity.dart';
// import '../../entities/history_entity.dart';
// import '../../repositories/history_repository.dart';
import '../repositories/user_control_repo.dart';

class SetUserPointData implements UseCase1<bool, PointUserHistoryDataModel> {
  final UserControlRepository repository;

  SetUserPointData(this.repository);

  @override
  Future<Result<bool>> call(PointUserHistoryDataModel user) async {
    return await repository.setUserPointData(user);
  }
}
