import 'package:flutter/material.dart';
import 'package:supapet/model/like.dart';
import 'package:supapet/utils.dart';

class LikeHandler {
  static String get dbName => 'likes';

  static Future addLike(Like like) async {
    try {
      await supabaseClient.from(dbName).insert(like.toMap()).csv();
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  static Future cancelLike(Like like) async {
    try {
      await supabaseClient
          .from(dbName)
          .update({'status': 0}).eq('like_id', like.likeID);
    } catch (e) {
      rethrow;
    }
  }

  static Future cancelLikePost(
      {required String postID, required String userID}) async {
    try {
      await supabaseClient.from(dbName).update({'status': 0}).match({
        'post_id': postID,
        'user_id': userID,
      });
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<String>> findUserLikePost(String userID) async {
    try {
      var data =
          await supabaseClient.from(dbName).select().eq('user_id', userID);
      var postIDs = List<String>.from(data.map((e) => e['post_id']));
      return postIDs;
    } catch (e) {
      rethrow;
    }
  }
}
