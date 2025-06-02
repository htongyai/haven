import 'package:intl/intl.dart';

class JournalEntry {
  final String id;
  final DateTime date;
  final String title;
  final String text;
  final String? mood;
  final String type;

  JournalEntry({
    required this.id,
    required this.date,
    required this.title,
    required this.text,
    this.mood,
    required this.type,
  });

  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} minutes ago';
      }
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  JournalEntry copyWith({
    String? id,
    DateTime? date,
    String? title,
    String? text,
    String? mood,
    String? type,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      text: text ?? this.text,
      mood: mood ?? this.mood,
      type: type ?? this.type,
    );
  }
}
