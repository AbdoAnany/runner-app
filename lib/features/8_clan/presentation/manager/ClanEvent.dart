abstract class ClanEvent {}

class RequestToJoinClan extends ClanEvent {
  final String clanId;
  final String userId;
  
  RequestToJoinClan({required this.clanId, required this.userId});
}

class AcceptInvite extends ClanEvent {
  final String clanId;
  final String userId;

  AcceptInvite({required this.clanId, required this.userId});
}

class AddMemberToClan extends ClanEvent {
  final String clanId;
  final String userId;

  AddMemberToClan({required this.clanId, required this.userId});
}
