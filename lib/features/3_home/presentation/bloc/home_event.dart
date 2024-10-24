part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {}

class RefreshHomeData extends HomeEvent {}

class UpdateHomeData extends HomeEvent {
  final UserDataDataModel userData;
  const UpdateHomeData({required this.userData});
}
class UpdateLevelData extends HomeEvent {
  final LevelSystem levelSystem;
  final String? token;
  const UpdateLevelData({required this.levelSystem,this.token});
}