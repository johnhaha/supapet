import 'package:flutter/material.dart';
import 'package:supapet/model/post.dart';
import 'package:supapet/utils.dart';

class PostHandler {
  static String get dbName => 'posts';

  static Future insertPost(Post post) async {
    try {
      await supabaseClient.from(dbName).insert(post.toMap()).csv();
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  static Future<List<Post>> findPosts(int skip) async {
    try {
      var data = await supabaseClient
          .from(dbName)
          .select('''
  *,pet:pets(*)
''')
          .eq('status', 1)
          .range(skip, skip + 10)
          .order('created_at', ascending: false);
      var posts = List<Post>.from(data.map((e) => Post.fromMap(e)));

      return posts;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Post>> findPetPosts(String petID) async {
    try {
      var data = await supabaseClient
          .from(dbName)
          .select()
          .eq('status', 1)
          .eq('pet_id', petID)
          .order('created_at', ascending: false);
      var posts = List<Post>.from(data.map((e) => Post.fromMap(e)));
      return posts;
    } catch (e) {
      rethrow;
    }
  }
}
