

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:runner_app/core/errors/failure.dart';

import 'package:runner_app/features/2_auth/data/models/user_model.dart';

import '../../../2_auth/data/models/UserDataDataModel.dart';
import '../../domain/repositories/user_control_repo.dart';

class UserControlRepositoryImpl implements UserControlRepository {
  @override
  Future<Result<bool>> deleteUserFromList() {
    // TODO: implement deleteUserFromList
    throw UnimplementedError();
  }

  @override
  Future<Result<UserDataDataModel>> getUserDetails() {
    // TODO: implement getUserDetails
    throw UnimplementedError();
  }

  @override
  Future<Result<List<UserDataDataModel>>> getUserList() async {

    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    //
    // QuerySnapshot snapshot = await firestore.collection('users').get();
    // return snapshot.docs.map((doc) => User.fromDocument(doc)).toList();

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
final List<UserDataDataModel> history = snapshot.docs.map((doc) => UserDataDataModel.fromJson(doc.data())).toList();
      // Retrieve the history list from the user's document
      return Result(Right(history));


      // return history;
    } catch (e) {
      print('Error getting history data: $e');
      return Result(Left(ServerFailure(e.toString())));

    }
  }

  @override
  Future<Result<UserDataDataModel>> updateUserDetails() {
    // TODO: implement updateUserDetails
    throw UnimplementedError();
  }


  
}
