import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../2_auth/data/models/UserDataDataModel.dart';
import '../../../2_auth/data/models/user_model.dart';
import '../../domain/use_cases/get_user_list.dart';

part 'userpoint_event.dart';
part 'userpoint_state.dart';

class UserPointBloc extends Bloc<UserPointEvent, UserPointState> {
  final GetUserListUseCase getUserListUseCase;

  UserPointBloc({
    required this.getUserListUseCase
}) : super(UserPointInitial()) {
    on<GetUserListEvent>(_getUserList);
    // on<AddUserPoint>(_addUserPoint);
    // on<RemoveUserPoint>(_removeUserPoint);
  }


  Future<void> _getUserList(GetUserListEvent event, Emitter<UserPointState> emit) async {

  final result = await getUserListUseCase(NoParams());
  print(result);
  result.result.fold(
        (failure) => emit(GetUserError(failure.toString())),
        (user) =>
    user != null ? emit(UserDateListLoaded(user)) : emit(GetUserError('no data')),
  );
  }
}
