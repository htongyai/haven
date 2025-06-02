import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void setUser(User user) {
    state = user;
  }

  void updateGlowScore(int newScore) {
    if (state != null) {
      state = state!.copyWith(glowScore: newScore);
    }
  }

  void clearUser() {
    state = null;
  }
}
