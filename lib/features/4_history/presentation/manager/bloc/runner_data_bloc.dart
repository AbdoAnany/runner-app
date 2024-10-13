// blocs/runner_data/runner_data_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../3_home/presentation/bloc/home_bloc.dart';
import '../../../../3_home/presentation/widgets/home_progress_level_steps_bar.dart';
import '../../../domain/entities/history_entity.dart';
import '../../../domain/use_cases/usecases/get_history_data.dart';
import '../../../domain/use_cases/usecases/set_history_data.dart';
import 'runner_data_event.dart';
import 'runner_data_state.dart';
class HistoryDataBloc extends Bloc<HistoryDataEvent, HistoryDataState> {
  final GetHistoryData getHistoryData;
  final SetHistoryData setHistoryData;
  final HomeBloc homeBloc;

  HistoryDataBloc({
    required this.getHistoryData,
    required this.setHistoryData,
    required this.homeBloc,
  }) : super(HistoryDataLoading()) {
    on<LoadHistoryData>(_onLoadHistoryData);
    on<AddHistoryData>(_onAddHistoryData);
    on<DeleteHistoryData>(_onDeleteHistoryData);
    on<UpdateLevelDataFromHome>(_onUpdateLevelDataFromHome);

    // Listen to HomeBloc state changes
    homeBloc.stream.listen((state) {
      if (state is HomeLoaded) {
        add(UpdateLevelDataFromHome(state.userDataDataModel));
      }
    });
  }

  Future<void> _onLoadHistoryData(
      LoadHistoryData event, Emitter<HistoryDataState> emit) async {
    try {
      var currentData = await getHistoryData.call();
      currentData.sort((a, b) => b.date.compareTo(a.date));
      int xp = currentData.fold(0, (accumulator, element) => (accumulator + element.xp));
      LevelSystem levelSystem = LevelSystem(currentXP: xp, currentLevel: 1);

      levelSystem.addXP(0); // Trigger level checking without additional XP
      homeBloc.add(UpdateLevelData(levelSystem: levelSystem));
      emit(HistoryDataLoaded(currentData, levelSystem));
    } catch (e) {
      emit(HistoryDataError(e.toString()));
    }
  }

  Future<void> _onAddHistoryData(
      AddHistoryData event, Emitter<HistoryDataState> emit) async {
    try {
      if (state is HistoryDataLoaded) {
        final List<HistoryEntity> currentData =
        List.from((state as HistoryDataLoaded).historyData);
        currentData.insert(0, event.historyEntity);
        int xp = currentData.fold(0, (accumulator, element) => (accumulator + element.xp));
        LevelSystem levelSystem = LevelSystem(currentXP: xp, currentLevel: 1);
        levelSystem.addXP(0); // Trigger level checking without additional XP
        await setHistoryData.addHistoryEntry(event.historyEntity);

        homeBloc.add(UpdateLevelData(levelSystem: levelSystem));
        emit(HistoryDataLoaded(currentData, levelSystem));
      }
    } catch (e) {
      emit(HistoryDataError(e.toString()));
    }
  }

  Future<void> _onDeleteHistoryData(
      DeleteHistoryData event, Emitter<HistoryDataState> emit) async {
    try {
      if (state is HistoryDataLoaded) {
        final List<HistoryEntity> currentData =
        List.from((state as HistoryDataLoaded).historyData);
        currentData.removeWhere((element) => element.id == event.historyEntity.id);
        int xp = currentData.fold(0, (accumulator, element) => (accumulator + element.xp));
        LevelSystem levelSystem = LevelSystem(currentXP: xp, currentLevel: 1);
        levelSystem.addXP(0); // Trigger level checking without additional XP
        await setHistoryData.deleteHistoryEntry(event.historyEntity);
        homeBloc.add(UpdateLevelData(levelSystem: levelSystem));
        emit(HistoryDataLoaded(currentData, levelSystem));
      }
    } catch (e) {
      print(e);
      emit(HistoryDataError(e.toString()));
    }
  }

  Future<void> _onUpdateLevelDataFromHome(
      UpdateLevelDataFromHome event, Emitter<HistoryDataState> emit) async {
    if (state is HistoryDataLoaded) {
      final currentState = state as HistoryDataLoaded;
      final updatedLevelSystem = LevelSystem(
        currentXP: event.userData.currentXP,
        currentLevel: event.userData.currentLevel,
      );
      emit(HistoryDataLoaded(currentState.historyData, updatedLevelSystem));
    }
  }

}