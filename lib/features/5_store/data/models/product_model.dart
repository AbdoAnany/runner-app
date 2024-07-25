import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.brand,
    required super.model,
    required super.price,
    required super.image,
    required super.isPopular,
  });

  factory ProductModel.fromSnapshot(DocumentSnapshot snap) {
    return ProductModel(
      id: snap.id,
      brand: snap['brand'],
      model: snap['model'],
      price: snap['price'].toDouble(),
      image: snap['image'],
      isPopular: snap['isPopular'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'price': price,
      'image': image,
      'isPopular': isPopular,
    };
  }
}