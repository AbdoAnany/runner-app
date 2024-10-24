import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../2_auth/data/models/UserDataDataModel.dart';
import '../../../2_auth/data/models/user_model.dart';
import '../../../3_home/data/models/user_data_model.dart';
import '../../../3_home/presentation/bloc/home_bloc.dart';
import '../../../3_home/presentation/widgets/home_progress_level_steps_bar.dart';
import '../../../4_history/data/models/history_data_model.dart';
import '../../../4_history/domain/entities/history_entity.dart';
import '../../domain/use_cases/get_user_list.dart';
import '../../domain/use_cases/set_user_point_data.dart';

part 'userpoint_event.dart';
part 'userpoint_state.dart';

class UserPointBloc extends Bloc<UserPointEvent, UserPointState> {
  final GetUserListUseCase getUserListUseCase;
  final SetUserPointData setUserPointData;
  final HomeBloc homeBloc;

  UserPointBloc({
    required this.getUserListUseCase,
    required this.setUserPointData,
    required this.homeBloc,
}) : super(UserPointInitial()) {
    on<GetUserListEvent>(_getUserList);
     on<AddUserPointEvent>(_addUserPoint);
    // on<RemoveUserPoint>(_removeUserPoint);
  }
  Future<void> _addUserPoint(AddUserPointEvent event, Emitter<UserPointState> emit) async {



  final res =   await setUserPointData(event.historyEntity);

  print("_addUserPoint  ..... ${res.result}");

  res.result.fold((l) => emit(AddUserPointDataError(l.message)), (r) => emit(AddUserPointDataSuccess(r)));
   LevelSystem levelSystem = LevelSystem(currentXP: event.historyEntity.xp, currentLevel: 1);
   levelSystem.addXP(0); // Trigger level checking without additional XP


   homeBloc.add(UpdateLevelData(levelSystem: levelSystem,token:event.fcmToken ));
  // emit(AddUserPointDataLoaded(currentData, levelSystem));
    // try {
    //   if (state is AddUserPointDataError) {
    //     // final List<HistoryEntity> currentData =
    //     // List.from((state as HistoryDataLoaded).historyData);
    //     // currentData.insert(0, event.historyEntity);
    //     // int xp = currentData.fold(0, (accumulator, element) => (accumulator + element.xp));
    //     // LevelSystem levelSystem = LevelSystem(currentXP: xp, currentLevel: 1);
    //     // levelSystem.addXP(0); // Trigger level checking without additional XP
    //     // await setHistoryData.addHistoryEntry(event.historyEntity);
    //     //
    //     // homeBloc.add(UpdateLevelData(levelSystem: levelSystem));
    //     // emit(HistoryDataLoaded(currentData, levelSystem));
    //   }
    // } catch (e) {
    //   emit(AddUserPointDataError(e.toString()));
    // }
  }

  Future<void> _getUserList(GetUserListEvent event, Emitter<UserPointState> emit) async {

  final result = await getUserListUseCase(NoParams());
  print("result ..... ${result.result}");
  result.result.fold(
        (failure) => emit(GetUserError(failure.toString())),
        (user) {
          print('result ..... ${user}');
          emit(UserDateListLoaded(user));
        } ,
  );
  }
}
