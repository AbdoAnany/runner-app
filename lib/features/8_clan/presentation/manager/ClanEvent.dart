import '../../data/models/ClanRole.dart';
import '../pages/ClanScreen.dart';

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

class LoadClan extends ClanEvent {
  final String clanId;
  LoadClan(this.clanId);
}

class InviteMember extends ClanEvent {
  final String userId;
  InviteMember(this.userId);
}

class PromoteMember extends ClanEvent {
  final String userId;
  final ClanRole newRole;
  PromoteMember(this.userId, this.newRole);
}

class RemoveMember extends ClanEvent {
  final String userId;
  RemoveMember(this.userId);
}



// Add these new events
class CreateClan extends ClanEvent {
  final String name;
  final String description;
  final int maxMembers;
  final String? imageUrl;

  CreateClan({
    required this.name,
    required this.description,
    required this.maxMembers,
    this.imageUrl,
  });
}

class SendJoinRequest extends ClanEvent {
  final String clanId;
  final String message;
  SendJoinRequest(this.clanId, this.message);
}

class HandleJoinRequest extends ClanEvent {
  final String requestId;
  final bool accept;
  HandleJoinRequest(this.requestId, this.accept);
}