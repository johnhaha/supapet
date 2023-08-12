import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supapet/handler/like.dart';
import 'package:supapet/handler/pet.dart';
import 'package:supapet/handler/post.dart';
import 'package:supapet/model/like.dart';
import 'package:supapet/model/pet.dart';
import 'package:supapet/model/post.dart';
import 'package:supapet/utils.dart';
import 'package:uuid/uuid.dart';

final appData = ChangeNotifierProvider((ref) => AppData());

class AppData extends ChangeNotifier {
  String? _userID;
  String? _token;
  List<Pet> _userPets = [];
  List<Post> _posts = [];
  List<String> _likedPosts = [];

  List<Pet> get userPets => _userPets;
  set userPet(List<Pet> data) {
    _userPets = data;
    notifyListeners();
  }

  List<Post> get posts => _posts;
  set post(List<Post> data) {
    _posts = data;
    notifyListeners();
  }

  set likedPosts(List<String> data) {
    _likedPosts = data;
    notifyListeners();
  }

  String? get userID => _userID;
  String? get token => _token;

  bool checkLogin() {
    return _userID != null && _token != null;
  }

  bool checkLikePost(String id) => _likedPosts.contains(id);

  void addAllPostUpdate(List<Post> data) {
    _posts.addAll(data);
    notifyListeners();
  }

  void addLikePostUpdate(String id) {
    _likedPosts.add(id);
    notifyListeners();
  }

  void remLikePostUpdate(String id) {
    _likedPosts.remove(id);
    notifyListeners();
  }

  void addPostUpdate(Post data) {
    _posts.insert(0, data);
    notifyListeners();
  }

  void loginUpdate({required String id, required String token}) {
    _userID = id;
    _token = token;
    supabaseClient.headers['Authorization'] = 'Bearer $token';
    notifyListeners();
  }

  void logoutUpdate() {
    _userID = null;
    _token = null;
    _userPets = [];
    notifyListeners();
  }

  void addPetUpdate(Pet data) {
    _userPets.insert(0, data);
    notifyListeners();
  }

  void remPetUpdate(Pet data) {
    _userPets.remove(data);
    notifyListeners();
  }

  Future findUserPets() async {
    try {
      var res = await PetHandler.findUserPets(userID!);
      userPet = res;
    } catch (e) {
      rethrow;
    }
  }

  Future findUserLikePost() async {
    try {
      var res = await LikeHandler.findUserLikePost(userID!);
      likedPosts = res;
    } catch (e) {
      rethrow;
    }
  }

  Future cancelLikePost(Post data) async {
    try {
      await LikeHandler.cancelLikePost(postID: data.postID, userID: userID!);
      remLikePostUpdate(data.postID);
    } catch (e) {
      rethrow;
    }
  }

  Future likePost(Post data) async {
    try {
      await LikeHandler.addLike(Like(
        postID: data.postID,
        userID: userID!,
        createdAt: DateTime.now(),
        petID: data.petID,
        likeID: Uuid().v4(),
        status: 1,
      ));
      addLikePostUpdate(data.postID);
    } catch (e) {
      rethrow;
    }
  }

  Future getPost({required bool more}) async {
    try {
      var res = await PostHandler.findPosts(more ? _posts.length : 0);
      if (more) {
        addAllPostUpdate(res);
      } else {
        post = res;
      }
    } catch (e) {
      rethrow;
    }
  }
}
