// domain/entities/user_data_entity.dart

// data/models/user_data_model.dart

import '../../domain/entities/history_entity.dart';

class HistoryDataModel extends HistoryEntity {
  HistoryDataModel({
    required super.id,
    required super.date,
    required super.distance,
    required super.pt,
    required super.kal,
    required super.xp,
  });

  factory HistoryDataModel.fromMap(Map<String, dynamic> map) {
    return HistoryDataModel(
      id: map['id'] ?? '0',
      date: map['date'] ?? '',
      distance: map['distance'] ?? '',
      pt: map['pt'] ?? '',
      kal: map['kal'] ?? '',
      xp: map['xp'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'distance': distance,
      'pt': pt,
      'kal': kal,
      'xp': xp,
    };
  }
}
