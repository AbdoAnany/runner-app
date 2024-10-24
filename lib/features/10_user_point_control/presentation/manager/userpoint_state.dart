part of 'userpoint_bloc.dart';


sealed class UserPointState extends Equatable{
  @override
  List<Object?> get props => [];
}

final class UserPointInitial extends UserPointState {}
final class UserPointLoading extends UserPointState {}
final class UserDateListLoaded extends UserPointState {

 final List<UserDataDataModel> userList;

  UserDateListLoaded(this.userList);
  @override
  List<Object> get props => [userList];
}
class GetUserError extends UserPointState {
  final String message;

  GetUserError(this.message);

  @override
  List<Object> get props => [message];
}


final class AddUserPointState extends UserPointState {}

class AddUserPointDataSuccess extends UserPointState {
  final bool isSuccess;

  AddUserPointDataSuccess(this.isSuccess);
}

class  AddUserPointDataLoaded extends UserPointState {
  final List<PointUserHistoryDataModel> historyData;
  final LevelSystem levelSystem;
  AddUserPointDataLoaded(this.historyData,this.levelSystem);
}


// class SaveDataLoaded extends UserPointState {
//   final HistoryEntity? historyData;
//
//   SaveDataLoaded(this.historyData);
// }

class AddUserPointDataError extends UserPointState {
  final String message;

  AddUserPointDataError(this.message);
}
