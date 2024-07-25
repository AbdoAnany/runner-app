import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class PopularProductItem extends StatelessWidget {
  final Product product;

  const PopularProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          product.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(product.model),
        subtitle: Text(product.brand),
        trailing: Text('\$${product.price.toStringAsFixed(2)}'),
      ),
    );
  }
}