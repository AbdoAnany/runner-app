import 'package:equatable/equatable.dart';
import '../../domain/entities/brand.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<Brand> brands;
  final List<Category> categories;
  final List<Product> popularProducts;

  const StoreLoaded({
    required this.brands,
    required this.categories,
    required this.popularProducts,
  });

  @override
  List<Object> get props => [brands, categories, popularProducts];
}

class StoreError extends StoreState {
  final String message;

  const StoreError({required this.message});

  @override
  List<Object> get props => [message];
}