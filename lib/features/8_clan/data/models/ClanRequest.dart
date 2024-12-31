import '../../presentation/pages/ClanScreen.dart';
import 'ClanMember.dart';

class ClanRequest {
  final String id;
  final String userId;
  final String userName;
  final DateTime requestDate;
  final String message;

  ClanRequest({
    required this.id,
    required this.userId,
    required this.userName,
    required this.requestDate,
    required this.message,
  });
}

// models/clan.dart
class Clan {
  final String id;
  final String name;
  final String description;
  final List<ClanMember> members;
  final int maxMembers;
  final String leaderId;
  final List<String> coLeaderIds;
  final String? imageUrl;
  final List<ClanRequest> joinRequests;
  final DateTime createdAt;

  Clan({
    required this.id,
    required this.name,
    required this.description,
    required this.members,
    required this.maxMembers,
    required this.leaderId,
    required this.coLeaderIds,
    this.imageUrl,
    required this.joinRequests,
    required this.createdAt,
  });

  bool isLeader(String userId) => leaderId == userId;
  bool isCoLeader(String userId) => coLeaderIds.contains(userId);
  bool canManageRequests(String userId) => isLeader(userId) || isCoLeader(userId);
}
