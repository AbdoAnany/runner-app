import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../data/datasources/firebase_store_datasource.dart';
import '../../data/repositories/store_repository_impl.dart';
import '../../domain/usecases/get_brands.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_popular_products.dart';
import '../bloc/store_bloc.dart';
import '../bloc/store_event.dart';
import '../bloc/store_state.dart';
import '../widgets/brand_list.dart';
import '../widgets/category_list.dart';
import '../widgets/popular_product_list.dart';

class StoreScreenBlocProvider extends StatelessWidget {
  const StoreScreenBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreBloc(
        getBrands: GetBrands(
          StoreRepositoryImpl(
            FirebaseStoreDatasource(),
          ),
        ),
        getCategories: GetCategories(
          StoreRepositoryImpl(
            FirebaseStoreDatasource(),
          ),
        ),
        getPopularProducts: GetPopularProducts(
          StoreRepositoryImpl(
            FirebaseStoreDatasource(),
          ),
        ),
      ),
      child: StoreScreen(),
    );
  }
}



class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          if (state is StoreInitial) {
            context.read<StoreBloc>().add(LoadStoreData());
            return LoadingWidget();
          } else if (state is StoreLoading) {
            return LoadingWidget();
          } else if (state is StoreLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<StoreBloc>().add(RefreshStoreData());
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CategoryList(categories: state.categories),
                    BrandList(brands: state.brands),
                    PopularProductList(
                      products: state.popularProducts,
                      onLoadMore: () {
                        context.read<StoreBloc>().add(LoadMorePopularProducts());
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is StoreError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}