// data/models/history_data_model.dart
import '../../data/entities/history_entity.dart';

class HistoryDataModel extends HistoryEntity {
  HistoryDataModel({
    required super.date,
    required super.distance,
    required super.pt,
    required super.kal,
    required super.steps,
  });

  factory HistoryDataModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return HistoryDataModel(

      date: map['date'],

      distance: map['distance'],
      pt: map['pt'],
      kal: map['kal'],
      steps: map['steps'],
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
