import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({

    required String name,
     String? image,
  }) : super( name: name, image: image);

  factory CategoryModel.fromJson(Map<String,dynamic> snap) {
    return CategoryModel(
    //  id: snap.id,
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