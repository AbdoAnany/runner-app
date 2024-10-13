import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../repositories/auth_repository.dart';

class VerifyPhoneNumber implements UseCase<void, VerifyPhoneNumberParams> {
  final AuthRepository repository;

  VerifyPhoneNumber(this.repository);

  @override
  Future<Either<Failure, void>> call(VerifyPhoneNumberParams params) async {
    return await repository.verifyPhoneNumber(params.phoneNumber, params.codeSent);
  }
}

class VerifyPhoneNumberParams {
  final String phoneNumber;
  final Function(String) codeSent;

  VerifyPhoneNumberParams({required this.phoneNumber, required this.codeSent});
}