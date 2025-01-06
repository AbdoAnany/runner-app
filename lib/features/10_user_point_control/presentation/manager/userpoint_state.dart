part of 'userpoint_bloc.dart';


sealed class UserPointState extends Equatable{
  late final List<UserDataDataModel> userList;

  @override
  List<Object?> get props => [];
}

final class UserPointInitial extends UserPointState {}
final class UserPointLoading extends UserPointState {}

final class UserDateListLoaded extends UserPointState {

   List<UserDataDataModel> userList;

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


enum HomeStatus {
  initial,
  loading,
  loaded,
  error,
}

extension HomeStatusX on HomeState {
  bool get isInitial => status == HomeStatus.initial;
  bool get isLoading => status == HomeStatus.loading;
  bool get isLoaded => status == HomeStatus.loaded;
  bool get isError => status == HomeStatus.error;
}

@immutable
class HomeState {
  final HomeStatus status;
  final List<UserDataDataModel>? userList;
  final String? errorMessage;
  final int? postIndex;

  HomeState({
    required this.status,
    this.userList=const [],
    this.errorMessage,
    this.postIndex,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<UserDataDataModel>? posts,
    String? errorMessage,
    int? postIndex,
  }) {
    return HomeState(
      status: status ?? this.status,
      userList: posts ?? this.userList,
      errorMessage: errorMessage ?? this.errorMessage,
      postIndex: postIndex ?? this.postIndex,
    );
  }

  @override
  String toString() =>
      'HomeState(status: $status, posts: $userList, errorMessage: $errorMessage, postIndex: $postIndex)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeState &&
        other.status == status &&
        listEquals(other.userList, userList) &&
        other.errorMessage == errorMessage &&
        other.postIndex == postIndex;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      userList.hashCode ^
      errorMessage.hashCode ^
      postIndex.hashCode;
}