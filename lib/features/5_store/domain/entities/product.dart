import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String brand;
  final String model;
  final double price;
  final String image;
  final bool isPopular;

  const Product({
    required this.id,
    required this.brand,
    required this.model,
    required this.price,
    required this.image,
    required this.isPopular,
  });

  @override
  List<Object?> get props => [id, brand, model, price, image, isPopular];
}