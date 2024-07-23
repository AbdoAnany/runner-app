import 'package:equatable/equatable.dart';

abstract class RunnerDataEvent extends Equatable {
  const RunnerDataEvent();

  @override
  List<Object> get props => [];
}

class LoadRunnerData extends RunnerDataEvent {}
