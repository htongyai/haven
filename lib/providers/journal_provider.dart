import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/journal_entry.dart';

final journalEntriesProvider =
    StateNotifierProvider<JournalEntriesNotifier, List<JournalEntry>>((ref) {
      return JournalEntriesNotifier();
    });

class JournalEntriesNotifier extends StateNotifier<List<JournalEntry>> {
  JournalEntriesNotifier() : super([]);

  void addEntry(JournalEntry entry) {
    state = [...state, entry];
  }

  void updateEntry(JournalEntry updatedEntry) {
    state =
        state.map((entry) {
          return entry.id == updatedEntry.id ? updatedEntry : entry;
        }).toList();
  }

  void deleteEntry(String id) {
    state = state.where((entry) => entry.id != id).toList();
  }

  List<JournalEntry> getEntriesByDate(DateTime date) {
    return state.where((entry) {
      return entry.date.year == date.year &&
          entry.date.month == date.month &&
          entry.date.day == date.day;
    }).toList();
  }
}
