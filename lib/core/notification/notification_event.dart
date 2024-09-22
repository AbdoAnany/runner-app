part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

class ReceiveXpNotification extends NotificationEvent {
  final int xp;
  final String topic;

  ReceiveXpNotification(this.xp, this.topic);
}
