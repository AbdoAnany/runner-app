// data/models/user_data_model.dart
class UserDataEntity {
   String userId;
   String date;
   String roles;
   String email;
   String name;
   String rank;
   String phone;
   int currentLevel;
   int currentXP;
   int xpForNextLevel;
   int activeNumber;
   int xpProgress;
   String adminId;
   String userState;
   String? photoUrl;
   String? fcmToken;



  UserDataEntity({
    required this.userId,
    required this.name,
    required this.fcmToken,
    required this.rank,
    required this.roles,
    required this.email,
    required this.phone,
    required this.date,
    required this.currentLevel,
    required this.currentXP,
    required this.photoUrl,
    required this.xpForNextLevel,
    required this.activeNumber,
    required this.xpProgress,
    required this.adminId,
    required this.userState,


  });
}

