import 'package:intl/intl.dart';

class CheckIn {
  final String id;
  final DateTime date;
  final String mood;
  final String reflectionText;

  CheckIn({
    required this.id,
    required this.date,
    required this.mood,
    required this.reflectionText,
  });

  String get formattedDate => DateFormat('MMM d, y').format(date);

  CheckIn copyWith({
    String? id,
    DateTime? date,
    String? mood,
    String? reflectionText,
  }) {
    return CheckIn(
      id: id ?? this.id,
      date: date ?? this.date,
      mood: mood ?? this.mood,
      reflectionText: reflectionText ?? this.reflectionText,
    );
  }
}
