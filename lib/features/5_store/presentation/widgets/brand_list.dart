import 'package:flutter/material.dart';
import '../../domain/entities/brand.dart';

class BrandList extends StatelessWidget {
  final List<Brand> brands;

  const BrandList({Key? key, required this.brands}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(brand.image),
                ),
                SizedBox(height: 4),
                Text(brand.name),
              ],
            ),
          );
        },
      ),
    );
  }
}