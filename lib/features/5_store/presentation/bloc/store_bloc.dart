import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_brands.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_popular_products.dart';
import 'store_event.dart';
import 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetBrands getBrands;
  final GetCategories getCategories;
  final GetPopularProducts getPopularProducts;

  StoreBloc({
    required this.getBrands,
    required this.getCategories,
    required this.getPopularProducts,
  }) : super(StoreInitial()) {
    on<LoadStoreData>(_onLoadStoreData);
    on<RefreshStoreData>(_onRefreshStoreData);
    on<LoadMorePopularProducts>(_onLoadMorePopularProducts);
  }

  Future<void> _onLoadStoreData(LoadStoreData event, Emitter<StoreState> emit) async {
    emit(StoreLoading());
    try {
      final brandsResult = await getBrands();
      final categoriesResult = await getCategories();
      final popularProductsResult = await getPopularProducts();

      brandsResult.fold(
            (failure) => emit(StoreError(message: failure.message)),
            (brands) => categoriesResult.fold(
              (failure) => emit(StoreError(message: failure.message)),
              (categories) => popularProductsResult.fold(
                (failure) => emit(StoreError(message: failure.message)),
                (popularProducts) => emit(StoreLoaded(
              brands: brands,
              categories: categories,
              popularProducts: popularProducts,
            )),
          ),
        ),
      );
    } catch (e) {
      emit(StoreError(message: e.toString()));
    }
  }

  Future<void> _onRefreshStoreData(RefreshStoreData event, Emitter<StoreState> emit) async {
    emit(StoreLoading());
    try {
      final brandsResult = await getBrands();
      final categoriesResult = await getCategories();
      final popularProductsResult = await getPopularProducts();

      brandsResult.fold(
            (failure) => emit(StoreError(message: failure.message)),
            (brands) => categoriesResult.fold(
              (failure) => emit(StoreError(message: failure.message)),
              (categories) => popularProductsResult.fold(
                (failure) => emit(StoreError(message: failure.message)),
                (popularProducts) => emit(StoreLoaded(
              brands: brands,
              categories: categories,
              popularProducts: popularProducts,
            )),
          ),
        ),
      );
    } catch (e) {
      emit(StoreError(message: e.toString()));
    }
  }

  Future<void> _onLoadMorePopularProducts(LoadMorePopularProducts event, Emitter<StoreState> emit) async {
    final currentState = state;
    if (currentState is StoreLoaded) {
      try {
        final moreProductsResult = await getPopularProducts();
        moreProductsResult.fold(
              (failure) => emit(StoreError(message: failure.message)),
              (moreProducts) => emit(StoreLoaded(
            brands: currentState.brands,
            categories: currentState.categories,
            popularProducts: [...currentState.popularProducts, ...moreProducts],
          )),
        );
      } catch (e) {
        emit(StoreError(message: e.toString()));
      }
    }
  }
}