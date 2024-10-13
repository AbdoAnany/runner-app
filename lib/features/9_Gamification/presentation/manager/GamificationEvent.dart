abstract class GamificationEvent {}

class UpdateXP extends GamificationEvent {
  final String userId;
  final int xpToAdd;

  UpdateXP({required this.userId, required this.xpToAdd});
}
