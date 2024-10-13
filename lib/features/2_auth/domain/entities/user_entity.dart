import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String role;
  bool isEmailVerified;
  String? displayName;
  String? photoUrl;
  UserEntity({
    required this.id,
    required this.email,
    this.role = 'user',
    this.displayName = "",
    this.isEmailVerified = false,
    this.photoUrl = "",
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, email, role, isEmailVerified, displayName, photoUrl];
}
