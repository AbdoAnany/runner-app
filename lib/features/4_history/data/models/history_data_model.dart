// domain/entities/history_entity.dart

// data/models/history_data_model.dart

import '../../domain/entities/history_entity.dart';

class HistoryDataModel extends HistoryEntity {
  HistoryDataModel({
    required super.id,
    required super.date,
    required super.distance,
    required super.pt,
    required super.kal,
    required super.steps,
  });

  factory HistoryDataModel.fromMap(Map<String, dynamic> map) {
    return HistoryDataModel(

      id: map['id']??'0',
      date: map['date']??'',

      distance: map['distance']??'',
      pt: map['pt']??'',
      kal: map['kal']??'',
      steps: map['steps']??'',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'distance': distance,
      'pt': pt,
      'kal': kal,
      'steps': steps,
    };
  }
}

