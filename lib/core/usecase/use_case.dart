import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../errors/failure.dart';
abstract class UseCaseRep<T,Params> {
  Future<dynamic> call(Params params);
}
abstract class UseCase<T, Params>implements UseCaseRep<T,Params> {
  @override
  Future<Either<Failure, T>> call(Params params);
}

abstract class UseCase1<T, Params>implements UseCaseRep<T,Params> {
  @override
  Future<Result<T>> call(Params params);
}



class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}


//abstract class UseCase<Type, Params>UseCase {
//   Future<Either<Failure, Type>> call(Params params);
// }