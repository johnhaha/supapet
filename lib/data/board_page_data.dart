import 'package:supapet/handler/pet.dart';
import 'package:supapet/model/pet.dart';

class BoardPageData {
  List<Pet> pets = [];

  Future getLikePet({
    required bool findMore,
  }) async {
    try {
      var res = await PetHandler.findMostLikePets(findMore ? pets.length : 0);
      if (findMore) {
        pets.addAll(res);
      } else {
        pets = res;
      }
    } catch (e) {
      rethrow;
    }
  }
}
