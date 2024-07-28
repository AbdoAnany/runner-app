// data/models/history_data_model.dart
class HistoryEntity {
  final String date;
  final double distance;
  final int pt;
  final int kal;
  final int steps;

  HistoryEntity({
    required this.date,
    required this.distance,
    required this.pt,
    required this.kal,
    required this.steps,
  });
}

