import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/brand.dart';
import '../entities/category.dart';
import '../entities/product.dart';

abstract class StoreRepository {
  Future<Either<Failure, List<Brand>>> getBrands();
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<Product>>> getPopularProducts();
}