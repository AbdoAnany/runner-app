import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/brand.dart';
import '../repositories/store_repository.dart';

class GetBrands {
  final StoreRepository repository;

  GetBrands(this.repository);

  Future<Either<Failure, List<Brand>>> call() async {
    return await repository.getBrands();
  }
}