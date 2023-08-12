import 'dart:convert';

import 'package:supapet/handler/store.dart';

class Pet {
  final String petID;
  final String userID;
  final String avatar;
  final String name;
  int status;
  int likeCount;
  Pet({
    required this.petID,
    required this.userID,
    required this.avatar,
    required this.name,
    this.status = 1,
    this.likeCount = 0,
  });

  String get avatarUrl => StoreHandler.getPublicUrl(avatar);

  Map<String, dynamic> toMap() {
    return {
      'pet_id': petID,
      'user_id': userID,
      'avatar': avatar,
      'name': name,
      'status': status,
      'like_count': likeCount,
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      petID: map['pet_id'] ?? '',
      userID: map['user_id'] ?? '',
      avatar: map['avatar'] ?? '',
      name: map['name'] ?? '',
      status: map['status']?.toInt() ?? 0,
      likeCount: map['like_count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pet.fromJson(String source) => Pet.fromMap(json.decode(source));
}
