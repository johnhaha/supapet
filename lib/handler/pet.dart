import 'package:flutter/material.dart';
import 'package:supapet/model/pet.dart';
import 'package:supapet/utils.dart';

class PetHandler {
  static String get dbName => 'pets';

  static Future insertPet(Pet pet) async {
    try {
      await supabaseClient.from(dbName).insert(pet.toMap()).csv();
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  static Future<Pet> getPet(String id) async {
    try {
      var data = await supabaseClient.from(dbName).select().eq('pet_id', id);
      var pet = Pet.fromMap(data.first);
      return pet;
    } catch (e) {
      rethrow;
    }
  }

  static Future updatePetLikeCount(String id) async {
    try {
      var res = await getPet(id);
      var data = await supabaseClient.from(dbName).update({
        'like_count': res.likeCount + 1,
      }).eq('pet_id', id);
      var pet = Pet.fromMap(data.first);
      return pet;
    } catch (e) {
      rethrow;
    }
  }

  static Future findMostLikePets(int skip) async {
    try {
      var data = await supabaseClient
          .from(dbName)
          .select()
          .eq('status', 1)
          .range(skip, skip + 10)
          .order('like_count', ascending: false);
      var pets = List<Pet>.from(data.map((e) => Pet.fromMap(e)));
      return pets;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Pet>> findUserPets(String userID) async {
    try {
      var data = await supabaseClient.from(dbName).select().match({
        'status': 1,
        'user_id': userID,
      });
      var pets = List<Pet>.from(data.map((e) => Pet.fromMap(e)));
      return pets;
    } catch (e) {
      rethrow;
    }
  }

  static Future remPet(Pet pet) async {
    try {
      await supabaseClient.from(dbName).update({
        'status': 0,
      }).eq('pet_id', pet.petID);
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Pet>> findPetWithID(List<String> petID) async {
    try {
      var data =
          await supabaseClient.from(dbName).select().in_('pet_id', petID);
      var pets = List<Pet>.from(data.map((e) => Pet.fromMap(e)));
      return pets;
    } catch (e) {
      rethrow;
    }
  }
}
