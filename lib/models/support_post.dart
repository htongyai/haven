import 'package:intl/intl.dart';

enum SupportCategory { justWannaTalk, needAFriend, wantingToInspire }

class SupportPost {
  final String id;
  final String? userId;
  final bool isAnonymous;
  final SupportCategory category;
  final String text;
  final DateTime date;
  final int lightCount;

  SupportPost({
    required this.id,
    this.userId,
    required this.isAnonymous,
    required this.category,
    required this.text,
    required this.date,
    this.lightCount = 0,
  });

  String get formattedDate => DateFormat('MMM d, y').format(date);

  String get categoryText {
    switch (category) {
      case SupportCategory.justWannaTalk:
        return 'Just Wanna Talk';
      case SupportCategory.needAFriend:
        return 'Need a Friend';
      case SupportCategory.wantingToInspire:
        return 'Wanting to Inspire';
    }
  }

  SupportPost copyWith({
    String? id,
    String? userId,
    bool? isAnonymous,
    SupportCategory? category,
    String? text,
    DateTime? date,
    int? lightCount,
  }) {
    return SupportPost(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      category: category ?? this.category,
      text: text ?? this.text,
      date: date ?? this.date,
      lightCount: lightCount ?? this.lightCount,
    );
  }
}
