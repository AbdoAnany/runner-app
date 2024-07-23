// runner_data_state.dart
import 'package:equatable/equatable.dart';

abstract class RunnerDataState extends Equatable {
  const RunnerDataState();

  @override
  List<Object> get props => [];
}

class RunnerDataLoading extends RunnerDataState {}

class RunnerDataLoaded extends RunnerDataState {
  final List<Map<String, dynamic>> historyData;
  final List<Map<String, dynamic>> popularData;

  const RunnerDataLoaded(this.historyData, this.popularData);

  @override
  List<Object> get props => [historyData, popularData];
}

class RunnerDataError extends RunnerDataState {}
