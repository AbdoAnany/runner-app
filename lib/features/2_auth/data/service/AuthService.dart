// Updated AuthService
import '../../../../core/errors/Result.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

// class AuthService {
//   final AuthRepository _repository;
//
//   AuthService(this._repository);
//
//   Future<Result<UserModel>> signIn(String email, String password) async {
//     return await _repository.signIn(email, password);
//   }
//
//   Future<Result<UserModel>> signUp(String email, String password, String role) async {
//     return await _repository.signUp(email, password, role);
//   }
//
//   // Implement other auth methods...
//
//   Future<Result<UserDataDataModel>> createUserData(UserDataDataModel userData) async {
//     return await _repository.createUserData(userData);
//   }
//
//   Future<Result<UserDataDataModel>> updateUserData(UserDataDataModel userData) async {
//     return await _repository.updateUserData(userData);
//   }
//
//   Future<Result<UserDataDataModel>> getUserData(String userId) async {
//     return await _repository.getUserData(userId);
//   }
// }