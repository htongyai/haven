class User {
  final String id;
  final String? name;
  final String? avatar;
  final int glowScore;

  User({required this.id, this.name, this.avatar, this.glowScore = 0});

  User copyWith({String? id, String? name, String? avatar, int? glowScore}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      glowScore: glowScore ?? this.glowScore,
    );
  }
}
