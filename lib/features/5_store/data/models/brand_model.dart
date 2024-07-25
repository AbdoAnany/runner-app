import '../../domain/entities/brand.dart';

class BrandModel extends Brand {
  const BrandModel({
   // required String id,
    required String name,
    required String image,
  }) : super( name: name, image: image);

  factory BrandModel.fromJson(Map<String,dynamic> snap) {
    return BrandModel(
 //     id: snap.id,
      name: snap['name'],
      image: snap['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
     // 'id': id,
      'name': name,
      'image': image,
    };
  }
}