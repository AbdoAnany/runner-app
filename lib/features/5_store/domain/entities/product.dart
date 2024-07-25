import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String brand;
  final String model;
  final double price;
  final String imageUrl;
  final bool isPopular;

  const Product({
    required this.id,
    required this.brand,
    required this.model,
    required this.price,
    required this.imageUrl,
    required this.isPopular,
  });

  @override
  List<Object?> get props => [id, brand, model, price, imageUrl, isPopular];
}