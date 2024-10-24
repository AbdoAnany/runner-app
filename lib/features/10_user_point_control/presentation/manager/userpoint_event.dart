part of 'userpoint_bloc.dart';

@immutable
abstract class UserPointEvent extends Equatable {
  @override
  List<Object> get props => [];
}

 class GetUserListEvent extends UserPointEvent {

   @override
   List<Object> get props => [];
 }

@immutable

class AddUserPointEvent extends UserPointEvent {

  final PointUserHistoryDataModel historyEntity;
  final String fcmToken;
  AddUserPointEvent(this.historyEntity,this.fcmToken);
  @override
  List<Object> get props => [];
}

