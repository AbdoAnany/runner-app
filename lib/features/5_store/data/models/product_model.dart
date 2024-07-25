import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required String id,
    required String brand,
    required String model,
    required double price,
    required String imageUrl,
    required bool isPopular,
  }) : super(
    id: id,
    brand: brand,
    model: model,
    price: price,
    imageUrl: imageUrl,
    isPopular: isPopular,
  );

  factory ProductModel.fromSnapshot(DocumentSnapshot snap) {
    return ProductModel(
      id: snap.id,
      brand: snap['brand'],
      model: snap['model'],
      price: snap['price'].toDouble(),
      imageUrl: snap['imageUrl'],
      isPopular: snap['isPopular'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'price': price,
      'imageUrl': imageUrl,
      'isPopular': isPopular,
    };
  }
}