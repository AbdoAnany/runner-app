// data/models/user_data_model.dart
class PointHistoryEntity {
  final String id;
  final String date;
  final String userId;

  final int xp;

  PointHistoryEntity({
    required this.id,
    required this.userId,
    required this.date,

    required this.xp,
  });
}

