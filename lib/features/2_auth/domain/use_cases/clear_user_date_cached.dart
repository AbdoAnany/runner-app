


import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class ClearUserDateCached implements UseCase<bool?, String> {
  final AuthRepository repository;

  ClearUserDateCached(this.repository);

  @override
  Future<Either<Failure, bool?>> call(String userId) async {
    return await repository.clearCachedUser(userId);
  }
}

