import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/store_repository.dart';

class GetPopularProducts {
  final StoreRepository repository;

  GetPopularProducts(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getPopularProducts();
  }
}