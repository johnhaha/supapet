import 'dart:convert';

import 'package:supapet/handler/store.dart';
import 'package:supapet/model/pet.dart';

class Post {
  final DateTime createdAt;
  final String postID;
  final String userID;
  final String petID;
  final String content;
  int likeCount;
  int disLikeCount;
  int status;
  Pet? pet;
  Post({
    required this.createdAt,
    required this.postID,
    required this.userID,
    required this.petID,
    required this.content,
    this.likeCount = 0,
    this.disLikeCount = 0,
    this.status = 1,
    this.pet,
  });

  String get contentUrl => StoreHandler.getPublicUrl(content);

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt.toIso8601String(),
      'post_id': postID,
      'user_id': userID,
      'pet_id': petID,
      'content': content,
      'like_count': likeCount,
      'dislike_count': disLikeCount,
      'status': status,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      createdAt: DateTime.parse(map['created_at']),
      postID: map['post_id'] ?? '',
      userID: map['user_id'] ?? '',
      petID: map['pet_id'] ?? '',
      content: map['content'] ?? '',
      likeCount: map['like_count']?.toInt() ?? 0,
      disLikeCount: map['dislike_count']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      pet: map['pet'] == null ? null : Pet.fromMap(map['pet']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}
