import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'GamificationEvent.dart';
import 'GamificationState.dart';

class GamificationBloc extends Bloc<GamificationEvent, GamificationState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  GamificationBloc() : super(InitialGamificationState());

  @override
  Stream<GamificationState> mapEventToState(GamificationEvent event) async* {
    if (event is UpdateXP) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(event.userId).get();
      int currentXP = userDoc['XP'];
      int newXP = currentXP + event.xpToAdd;

      // Calculate new level and rank
      int newLevel = calculateLevel(newXP);
      String newRank = calculateRank(newLevel);

      await _firestore.collection('users').doc(event.userId).update({
        'XP': newXP,
        'level': newLevel,
        'rank': newRank,
      });
      yield XPUpdated();
    }
  }

  int calculateLevel(int xp) {
    // Define level-up thresholds (this can be dynamic)
    return (xp / 100).floor();
  }

  String calculateRank(int level) {
    // Example rank calculation based on level
    if (level >= 10) {
      return "Master";
    } else if (level >= 5) {
      return "Expert";
    } else {
      return "Novice";
    }
  }
}
