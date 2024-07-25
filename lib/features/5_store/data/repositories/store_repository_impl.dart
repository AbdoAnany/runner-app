import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/brand.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/store_repository.dart';
import '../datasources/firebase_store_datasource.dart';

class StoreRepositoryImpl implements StoreRepository {
  final FirebaseStoreDatasource datasource;

  StoreRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<Brand>>> getBrands() async {
    try {
      final result = await datasource.getBrands();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final result = await datasource.getCategories();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getPopularProducts() async {
    try {
      final result = await datasource.getPopularProducts();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}