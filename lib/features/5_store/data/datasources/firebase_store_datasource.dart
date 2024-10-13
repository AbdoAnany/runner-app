import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runner_app/features/2_auth/presentation/manager/auth/auth_bloc.dart';

import '../../../../core/const/const.dart';
import '../local_datasources/local_datesource.dart';
import '../models/brand_model.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class FirebaseStoreDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BrandModel>> getBrands() async {
  //  final snapshot = await _firestore.collection('brands').get();
//    return snapshot.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
    return brandList.map((doc) => BrandModel.fromJson(doc)).toList();

  }

  Future<List<CategoryModel>> getCategories() async {
  //  final snapshot = await _firestore.collection('categories').get();

    return categoryList.map((doc) => CategoryModel.fromJson(doc)).toList();
  }

  Future<List<ProductModel>> getPopularProducts() async {
   // await setPopularProducts();


    final snapshot =
    // AuthBloc.currentUser?.role=="admin"?
    // await _firestore.collection('products')
    //     //.where('isPopular', isEqualTo: true)
    //     .get():
    await _firestore.collection('products').where('isPopular', isEqualTo: true).get()
    ;
    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }
  Future<void> setPopularProducts() async {
    final List<ProductModel> products = [
      ProductModel(
        id: '1',
        brand: 'Nike',
        model: 'Air Zoom Pegasus 38',
        price: 1200.0,
        image:  AppImage.nike1,
        isPopular: true,
      ),
      ProductModel(
        id: '2',
        brand: 'Adidas',
        model: 'Ultraboost 21',
        price: 1800.0,
        image: AppImage.nike2,
        isPopular: true,
      ),

    ];

    final batch = _firestore.batch();

    for (var product in products) {
      final docRef = _firestore.collection('products').doc();
      batch.set(docRef, product.toJson());
    }

    await batch.commit();
  }
}