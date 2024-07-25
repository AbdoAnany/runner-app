import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import 'popular_product_item.dart';

class PopularProductList extends StatelessWidget {
  final List<Product> products;
  final VoidCallback onLoadMore;

  const PopularProductList({
    Key? key,
    required this.products,
    required this.onLoadMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Popular Products',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: products.length + 1,
          itemBuilder: (context, index) {
            if (index == products.length) {
              return ElevatedButton(
                onPressed: onLoadMore,
                child: Text('Load More'),
              );
            }
            return PopularProductItem(product: products[index]);
          },
        ),
      ],
    );
  }
}