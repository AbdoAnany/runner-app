// data/models/user_data_model.dart
class UserDataEntity {
  final String userId;
  final String date;
  final String roles;
  final String email;
  final String name;
  final String rank;
  final String phone;
  final int currentLevel;
  final int currentXP;
  final int xpForNextLevel;
  final int activeNumber;
  final int xpProgress;
  final String adminId;
  final String userState;



  UserDataEntity({
    required this.userId,
    required this.name,
    required this.rank,
    required this.roles,
    required this.email,
    required this.phone,
    required this.date,
    required this.currentLevel,
    required this.currentXP,
    required this.xpForNextLevel,
    required this.activeNumber,
    required this.xpProgress,
    required this.adminId,
    required this.userState,


  });
}

