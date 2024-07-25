import 'package:equatable/equatable.dart';

class Category extends Equatable {
 // final String id;
  final String name;
  final String? image;

  const Category({
  //  required this.id,
    required this.name,
     this.image,
  });

  @override
  List<Object?> get props => [
    //id,
    name, image];
}