import 'package:cloud_firestore/cloud_firestore.dart';
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
    final snapshot = await _firestore.collection('products')
        .where('isPopular', isEqualTo: true)
        .get();
    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }
}