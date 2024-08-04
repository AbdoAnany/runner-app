class UserEntity {
  final String id;
  final String email;
  final String role;

  UserEntity({
    required this.id,
    required this.email,
    required this.role,
  });
  // // Optionally, you can add methods to serialize/deserialize the object
  // factory UserEntity.fromJson(Map<String, dynamic> json) {
  //   return UserEntity(
  //     id: json['id'],
  //     email: json['email'],
  //     role: json['role'],
  //   );
  // }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'email': email,
  //     'role': role,
  //   };
  // }
}
