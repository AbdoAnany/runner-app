import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:runner_app/core/helper/game.dart';
import 'package:runner_app/features/2_auth/presentation/manager/auth/auth_bloc.dart';


import '../../data/models/user_data_model.dart';
import '../../domain/use_cases/usecases/get_user_data.dart';
import '../../domain/use_cases/usecases/set_user_data.dart';
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
    try {

      final userDataServer = await getUserData();
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
      final userDataServer = await getUserData();
      userData=userDataServer;
      emit(HomeLoaded(userDataDataModel: userDataServer,));

    } catch (e) {
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
      emit(HomeError(message: e.toString()));
    }
  }
  Future<void> _onUpdateLevelData(UpdateLevelData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      // Fetch the current user data
      final currentUserData = await getUserData();

      // Update the level system data
      final updatedUserData = currentUserData.copyWith(
        currentLevel: event.levelSystem.currentLevel,
        currentXP: event.levelSystem.currentXP,
        xpForNextLevel: event.levelSystem.xpForNextLevel,
        xpProgress: event.levelSystem.getXPProgress(),
      );

      // Update the user data in the database
      await setUserData.updateUserData(updatedUserData);

      // Update the static userData variable
      userData = updatedUserData;

      // Emit the updated state
      emit(HomeLoaded(userDataDataModel: updatedUserData));
    } catch (e) {
      print('Error updating level data: $e');
      emit(HomeError(message: e.toString()));
    }
  }}