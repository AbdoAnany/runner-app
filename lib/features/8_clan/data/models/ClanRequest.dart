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
  String id='';
  String name='';
  String description='';
  List<String> members=[];
  int maxMembers=0;
  String leaderId='';
  List<String> coLeaderIds=[];
  List<String> joinRequests=[];
  String createdAt='';

  Clan(
      {this.id="",
        this.name='No Name',
        this.description='',
        this.members=const [],
        this.maxMembers=2,
        this.leaderId='',
        this.coLeaderIds=const [],
        this.joinRequests=const [],
        this.createdAt=''});

  Clan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    members = json['members'].cast<String>();
    maxMembers = json['maxMembers'];
    leaderId = json['leaderId'];
    coLeaderIds = json['coLeaderIds'].cast<String>();
    joinRequests = json['joinRequests'].cast<String>();
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['members'] = this.members;
    data['maxMembers'] = this.maxMembers;
    data['leaderId'] = this.leaderId;
    data['coLeaderIds'] = this.coLeaderIds;
    data['joinRequests'] = this.joinRequests;
    data['createdAt'] = this.createdAt;
    return data;
  }
  bool isLeader(String userId) => leaderId == userId;
  bool isCoLeader(String userId) => coLeaderIds.contains(userId);
  bool canManageRequests(String userId) => isLeader(userId) || isCoLeader(userId);
}


