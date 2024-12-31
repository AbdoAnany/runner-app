import '../../data/models/ClanRequest.dart';
import '../pages/ClanDetailsScreen.dart';

abstract class ClanState {}

class ClanInitial extends ClanState {}

class ClanRequestSent extends ClanState {}

class ClanInviteAccepted extends ClanState {}

class MemberAdded extends ClanState {}
// bloc/clan_state.dart

class ClanLoading extends ClanState {}
class ClanLoaded extends ClanState {
  final Clan clan;
  ClanLoaded(this.clan);
}
class ClanError extends ClanState {
  final String message;
  ClanError(this.message);
}
class ClanActionSuccess extends ClanState {
  final String message;
  ClanActionSuccess(this.message);
}
