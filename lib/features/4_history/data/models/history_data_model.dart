// domain/entities/user_data_entity.dart

// data/models/user_data_model.dart

import '../../domain/entities/history_entity.dart';

class PointUserHistoryDataModel extends PointHistoryEntity {
  PointUserHistoryDataModel({
    required super.id,
    required super.userId,
    required super.date,

    required super.xp,
  });

  factory PointUserHistoryDataModel.fromMap(Map<String, dynamic> map) {
    return PointUserHistoryDataModel(
      id: map['id'] ?? '0',
      userId: map['userId'] ?? '0',
      date: map['date'] ?? '',

      xp: map['xp'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'userId': userId,

      'xp': xp,
    };
  }
}
