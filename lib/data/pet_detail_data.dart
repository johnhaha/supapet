import 'package:supapet/handler/pet.dart';
import 'package:supapet/model/pet.dart';
import 'package:supapet/model/post.dart';

import '../handler/post.dart';

class PetDetailData {
  final String petID;
  PetDetailData(this.petID);

  Pet? pet;
  List<Post> posts = [];

  Future getPet() async {
    try {
      pet = await PetHandler.getPet(petID);
    } catch (e) {
      rethrow;
    }
  }

  Future getPosts() async {
    try {
      posts = await PostHandler.findPetPosts(petID);
    } catch (e) {
      rethrow;
    }
  }
}
