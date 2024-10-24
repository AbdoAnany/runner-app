part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}


class NotificationReceived extends NotificationState {
  final PointHistoryEntity? updatedEntry;

  NotificationReceived(this.updatedEntry);
}