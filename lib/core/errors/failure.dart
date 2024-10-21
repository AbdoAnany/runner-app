import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object> get props => [message];
}
class Result<T> {
  final Either<Failure, T> result;

  Result(this.result);

  // Optionally, you can add utility methods
  bool get isSuccess => result.isRight();
  bool get isFailure => result.isLeft();
  T? get value => result.getOrElse(() => null as T);

  Failure? get error => result.fold((l) => l, (r) => null);
}


class ServerFailure extends Failure {
  const ServerFailure(super.message);
}class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}
class AuthFailure extends Failure {
  const AuthFailure(super.message);
  @override
  List<Object> get props => [message];
}


class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

