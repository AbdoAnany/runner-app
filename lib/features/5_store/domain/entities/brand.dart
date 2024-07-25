import 'package:equatable/equatable.dart';

class Brand extends Equatable {
 // final String id;
  final String name;
  final String image;

  const Brand({
  //  required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [ name, image];
}