import '../../data/models/ClanRequest.dart';

abstract class ClanState {}

class ClanInitial extends ClanState {}

class ClanRequestSent extends ClanState {}

class ClanInviteAccepted extends ClanState {}

class MemberAdded extends ClanState {}
// bloc/clan_state.dart

class ClanLoading extends ClanState {}
class ClanLoaded extends ClanState {
  final List<Clan> clans;
  ClanLoaded(this.clans);
}
class ClanError extends ClanState {
  final String message;
  ClanError(this.message);
}
class ClanActionSuccess extends ClanState {
  final String message;
  ClanActionSuccess(this.message);
}

class ClanCreated extends ClanState {
  final Clan clan;
  ClanCreated(this.clan);
}