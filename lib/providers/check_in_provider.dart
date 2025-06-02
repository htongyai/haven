import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/check_in.dart';

final checkInsProvider = StateNotifierProvider<CheckInsNotifier, List<CheckIn>>(
  (ref) {
    return CheckInsNotifier();
  },
);

class CheckInsNotifier extends StateNotifier<List<CheckIn>> {
  CheckInsNotifier() : super([]);

  void addCheckIn(CheckIn checkIn) {
    state = [...state, checkIn];
  }

  void updateCheckIn(CheckIn updatedCheckIn) {
    state =
        state.map((checkIn) {
          return checkIn.id == updatedCheckIn.id ? updatedCheckIn : checkIn;
        }).toList();
  }

  void deleteCheckIn(String id) {
    state = state.where((checkIn) => checkIn.id != id).toList();
  }

  CheckIn? getLatestCheckIn() {
    if (state.isEmpty) return null;
    return state.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
  }
}
