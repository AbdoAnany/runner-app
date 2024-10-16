import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> signIn(String email, String password) async {
    User user = await remoteDataSource.signIn(email, password);
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    String role = userDoc['role'];
    return UserEntity(id: user.uid, email: user.email!, role: role);
  }

  @override
  Future<void> signUp(String email, String password, String role) {
    return remoteDataSource.signUp(email, password, role);
  }

  @override
  Future<List<String>> fetchRoles() {
    return remoteDataSource.fetchRoles();
  }
}
