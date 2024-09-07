// data/models/user_data_model.dart
class HistoryEntity {
  final String id;
  final String date;
  final double distance;
  final int pt;
  final int kal;
  final int xp;

  HistoryEntity({
    required this.id,
    required this.date,
    required this.distance,
    required this.pt,
    required this.kal,
    required this.xp,
  });
}

