import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:runner_app/features/3_home/data/entities/user_data_entity.dart';

import '../../features/4_history/data/entities/history_entity.dart';
import '../../features/4_history/domain/entities/history_entity.dart';

part 'notification_event.dart';
part 'notification_state.dart';




// BLoC
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<ReceiveXpNotification>(_onReceiveXpNotification);
  }

  void _onReceiveXpNotification(ReceiveXpNotification event, Emitter<NotificationState> emit) {

    final updatedEntry = HistoryEntity(

      id : DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now().toIso8601String(),
       // You might want to update this based on your logic
      xp: event.xp,
    );

    emit(NotificationReceived(updatedEntry));
  }
}