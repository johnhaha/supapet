import 'dart:convert';

class Like {
  final DateTime createdAt;
  final String likeID;
  final String userID;
  final String postID;
  final String petID;
  int status;
  Like({
    required this.createdAt,
    required this.likeID,
    required this.userID,
    required this.postID,
    required this.petID,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt.toIso8601String(),
      'like_id': likeID,
      'user_id': userID,
      'post_id': postID,
      'pet_id': petID,
      'status': status,
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      createdAt: DateTime.parse(map['created_at']),
      likeID: map['like_id'] ?? '',
      userID: map['user_id'] ?? '',
      postID: map['post_id'] ?? '',
      petID: map['pet_id'] ?? '',
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Like.fromJson(String source) => Like.fromMap(json.decode(source));
}
