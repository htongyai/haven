import 'package:intl/intl.dart';

class BreathworkSession {
  final String id;
  final DateTime date;
  final String type;
  final int duration;

  BreathworkSession({
    required this.id,
    required this.date,
    required this.type,
    required this.duration,
  });

  String get formattedDate => DateFormat('MMM d, y').format(date);

  BreathworkSession copyWith({
    String? id,
    DateTime? date,
    String? type,
    int? duration,
  }) {
    return BreathworkSession(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      duration: duration ?? this.duration,
    );
  }
}
