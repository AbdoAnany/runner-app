
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class GetCachedUser implements UseCase<UserDataDataModel?, String> {
  final AuthRepository repository;

  GetCachedUser(this.repository);

  @override
  Future<Either<Failure, UserDataDataModel?>> call(String userId) async {
    return await repository.getCachedUser(userId);
  }
}

