import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/notification_service/notifcation_service.dart';
import '../../../../core/service/NotificationService.dart';
import '../../../../dependency_injection.dart';
import '../../data/models/user_data_model.dart';
import '../../domain/use_cases/usecases/get_user_data.dart';
import '../../domain/use_cases/usecases/set_user_data.dart';
import '../widgets/home_progress_level_steps_bar.dart';

part 'home_event.dart';
part 'home_state.dart';
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserData getUserData;
  final SetUserData setUserData;
 static UserDataDataModel? userData;

  HomeBloc({
    required this.getUserData,
    required this.setUserData,

  }) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<RefreshHomeData>(_onRefreshHomeData);
    on<UpdateHomeData>(_onUpdateHomeData);
    on<UpdateLevelData>(_onUpdateLevelData);
  }

  Future<void> _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    print("-------------------- _onLoadHomeData   ");


    try {

      final userDataServer = await getUserData(FirebaseAuth.instance.currentUser!.uid);
      userData=userDataServer;
     emit(HomeLoaded(userDataDataModel: userDataServer,));
    } catch (e) {
      print('>>>>>>>>>>>>  ${e}');
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onRefreshHomeData(RefreshHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      print("-------------------- _onRefreshHomeData   ");

      final userDataServer = await getUserData(event);
      userData=userDataServer;
      emit(HomeLoaded(userDataDataModel: userDataServer,));

    } catch (e) {
      print('_onRefreshHomeData >>>>>>>>>>>>  ${e}');
      emit(HomeError(message: e.toString()));
    }
  }
  Future<void> _onUpdateHomeData(UpdateHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
    await setUserData.updateUserData(event.userData);
      // userData=userDataServer;
      emit(HomeLoaded(userDataDataModel: event.userData));

    } catch (e) {
      print('_onUpdateHomeData >>>>>>>>>>>>  ${e}');

      emit(HomeError(message: e.toString()));
    }
  }
  Future<void> _onUpdateLevelData(UpdateLevelData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      // Fetch the current user data
      // print("_onUpdateLevelData ${event.levelSystem.currentLevel}");
      final currentUserData = await getUserData(FirebaseAuth.instance.currentUser!.uid);

      currentUserData.xpProgress= event.levelSystem.getXPProgress().toInt();
      currentUserData.currentLevel= event.levelSystem.currentLevel;
      currentUserData.rank= 'A';

      // Update the user data in the database
      await setUserData.updateUserData(currentUserData);
      print("_onUpdateLevelData ${currentUserData.toMap()}");

      // Update the static userData variable
      userData = currentUserData;
      String title;
      String message;
      int levelChange = event.levelSystem.currentLevel - currentUserData.currentLevel;

      if (levelChange > 0) {
        // Level up
        title = "Level Up! 🎉";
        message = "Congratulations! You've reached Level ${event.levelSystem.currentLevel}!";
      } else if (levelChange < 0) {
        // Level down
        title = "Level Change 📉";
        message = "Your level has changed to ${event.levelSystem.currentLevel}. Keep working to improve!";
      }  else {
        title = "XP Gained! 💪";
        message = "You've  ${event.levelSystem.currentLevel} XP! Keep going!";
      }

      // Add XP details to the message
      message += "\nXP: ${event.levelSystem.currentXP}/${event.levelSystem.xpForNextLevel}";
      message += "\nProgress: ${(event.levelSystem.getXPProgress() * 100).toStringAsFixed(1)}% to next level";

      sendNotification(
          title: title,
          message: message,
          fcmToken:event.fcmToken,
          // topic: 'history',
          data: currentUserData.toMap()
      );

      // Emit the updated state
      // emit(HomeLoaded(userDataDataModel: currentUserData));
       emit(const HomeSuccess(message: 'Success'));
    } catch (e) {
      print('Error updating level data: $e');
      emit(HomeError(message: e.toString()));
    }
  }


  sendNotification({String? title,String? message,String? topic,String? fcmToken, required Map<String, dynamic> data}) async {
    // String? token = await FirebaseMessaging.instance.getToken();
    print("token >>>>>>>>>>>>>>>>>>>>>>>>");
    print(fcmToken);
    if (fcmToken != null) {
      NotificationService().sendNotification(
        title: title ?? 'Dynamic Notification',
        topic: topic  ,
        message: message ?? 'This is a test of dynamic data!',
        registrationTokens: fcmToken,
        data: data,
      );
    } else {
      print('Unable to get FCM token');
    }
  }


}


