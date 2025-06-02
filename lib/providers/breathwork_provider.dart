import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/breathwork_session.dart';

final breathworkSessionsProvider =
    StateNotifierProvider<BreathworkSessionsNotifier, List<BreathworkSession>>((
      ref,
    ) {
      return BreathworkSessionsNotifier();
    });

class BreathworkSessionsNotifier
    extends StateNotifier<List<BreathworkSession>> {
  BreathworkSessionsNotifier() : super([]);

  void addSession(BreathworkSession session) {
    state = [...state, session];
  }

  void updateSession(BreathworkSession updatedSession) {
    state =
        state.map((session) {
          return session.id == updatedSession.id ? updatedSession : session;
        }).toList();
  }

  void deleteSession(String id) {
    state = state.where((session) => session.id != id).toList();
  }

  List<BreathworkSession> getSessionsByDate(DateTime date) {
    return state.where((session) {
      return session.date.year == date.year &&
          session.date.month == date.month &&
          session.date.day == date.day;
    }).toList();
  }

  int getTotalDuration() {
    return state.fold(0, (sum, session) => sum + session.duration);
  }
}
