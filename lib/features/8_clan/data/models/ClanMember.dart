import '../../presentation/pages/ClanScreen.dart';
import 'ClanRole.dart';

class ClanMember {
  final String id;
  final String name;
  final ClanRole role;
  final DateTime joinDate;

  ClanMember({
    required this.id,
    required this.name,
    required this.role,
    required this.joinDate,
  });
}

// // models/clan.dart
// class Clan {
//   final String id;
//   final String name;
//   final String description;
//   final List<ClanMember> members;
//   final int maxMembers;
//   final String leaderId;
//   final List<String> coLeaderIds;
//
//   Clan({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.members,
//     required this.maxMembers,
//     required this.leaderId,
//     required this.coLeaderIds,
//   });
//
//   bool isLeader(String userId) => leaderId == userId;
//   bool isCoLeader(String userId) => coLeaderIds.contains(userId);
// }